class ServiceRepository < ROM::Repository::Root
  include Import[
    'relations.volgaspot_services',
    'relations.volgaspot_tariff_links',
    'mappers.services_mapper',
    'mappers.volgaspot_services_mapper'
  ]

  root :services

  auto_struct false
  struct_namespace Rapi::Entities

  def additional_services_by_ids(ids)
    additional_service_ids = services.additional.by_id(ids).ids
    get_services additional_service_ids
  end

  def services_by_ids(ids)
    main_service_ids = services.main.by_id(ids).ids
    get_services main_service_ids
  end

  private

  def get_services(ids)
    volgaspot_data_thread = Thread.new { volgaspot_service_data ids }
    utm_service_data = utm_service_data ids
    volgaspot_service_data = volgaspot_data_thread.join.value
    merge_service_data utm_service_data, volgaspot_service_data
    services_mapper.call utm_service_data
  end

  def utm_service_data(ids)
    services.by_id(ids).to_a
  end

  def volgaspot_service_data(ids)
    tuples = volgaspot_services.base.by_ids(ids).to_a
    volgaspot_services_mapper.call tuples
  end

  def merge_service_data(source, *additional_sources)
    source.each do |service|
      Array(additional_sources).each do |additional_source|
        additional_data = additional_source.find { |as| as[:id] == service[:id] }
        service.merge! additional_data if additional_data
      end
    end
  end
end
