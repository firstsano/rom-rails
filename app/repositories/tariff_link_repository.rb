class TariffLinkRepository < ::ROM::Repository::Root
  include Import[
    'relations.available_tariffs',
    'relations.services',
    'relations.volgaspot_tariffs',
    'relations.volgaspot_tariff_links',
    service_repo: 'repositories.service',
    tariff_repo: 'repositories.tariff',
    vs_mapper: 'mappers.volgaspot_tariff_links_mapper'
  ]

  root :tariffs

  auto_struct false
  struct_namespace Rapi::Entities

  def tariffs_by_user(id)
    tariff_link = find_tariff_link_by_user id
    return [] unless tariff_link

    service_ids = tariff_link[:service_links_data].map { |slink| slink[:id] }
    tariff_data = tariff_repo
      .tariffs_by_ids(tariff_link[:id], with_services: false)
      .first
    service_data = service_repo.services_by_ids service_ids
    tariff_data = tariff_data.to_hash
    tariff_data[:services] = service_data
    tariff_link[:tariff] = tariff_data
    Volgaspot::TariffLink.new tariff_link
  end

  def available_tariffs_for_user(id)
    tariff_ids = get_available_tariffs_for_user(id).map { |el| el[:id] }
    return [] if tariff_ids.empty?

    tariff_repo.tariffs_by_ids tariff_ids
  end

  def unlink_tariff_for_user(id)
    response = volgaspot_tariff_links.command(:delete).call id
    response[:success] && response[:data]
  end

  def link_tariff_for_user(id, tariff_id)
    response = volgaspot_tariff_links.command(:create).call id, tariff_id
    response[:success]
  end

  private

  def get_available_tariffs_for_user(id)
    available_tariffs.base.by_user(id).to_a
  end

  # TODO: find a way for mapper to skip empty values and call it here
  def find_tariff_link_by_user(id)
    raw_tuple = volgaspot_tariff_links.base.by_user(id).one
    return false if raw_tuple[:active_tariff_link].empty?

    vs_mapper.call([raw_tuple]).first
  end
end
