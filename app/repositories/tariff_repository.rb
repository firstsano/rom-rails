class TariffRepository < ::ROM::Repository::Root
  include Import[
    'relations.volgaspot_tariffs',
    'mappers.tariffs_mapper',
    service_repo: 'repositories.service'
  ]

  root :tariffs

  auto_struct false
  struct_namespace Rapi::Entities

  def tariffs_by_ids(ids, with_services: true)
    volgaspot_data_thread = Thread.new { volgaspot_tariff_data ids }
    utm_tariff_data = utm_tariff_data ids
    fill_tariffs_with_services!(utm_tariff_data) if with_services
    volgaspot_tariff_data = volgaspot_data_thread.join.value
    merge_tariff_data! utm_tariff_data, volgaspot_tariff_data
    tariffs_mapper.call utm_tariff_data
  end

  private

  def fill_tariffs_with_services!(tariff_data)
    required_services = get_tariffs_services_ids tariff_data
    tariff_data.each do |tariff|
      service_ids = tariff[:services].map { |service| service[:id] }
      tariff[:services] = required_services.select { |service| service_ids.include? service.id }
    end
  end

  def get_tariffs_services_ids(tariffs)
    services = tariffs.map { |tariff| tariff[:services] }.flatten
    service_ids = services.map { |service| service[:id] }.sort.uniq
    return [] unless service_ids

    service_repo.services_by_ids service_ids
  end

  # Select :tariff_id too, because selecting :id only
  # causes output tuple to contain empty array under :services key
  def utm_tariff_data(ids)
    tariffs.by_id(ids).combine(:services).node(:services, &:main)
           .node(:services) { |services| services.select(:id, :tariff_id) }
           .to_a
  end

  def volgaspot_tariff_data(ids)
    volgaspot_tariffs.base.by_ids(ids).to_a
  end

  def merge_tariff_data!(source, *additional_sources)
    source.each do |tariff|
      Array(additional_sources).each do |additional_source|
        additional_data = additional_source.find { |as| as[:id] == tariff[:id] }
        tariff.merge! additional_data if additional_data
      end
    end
  end
end
