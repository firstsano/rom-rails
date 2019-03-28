class ServiceLinkRepository < ROM::Repository::Root
  include Import[
    'relations.volgaspot_services',
    'relations.volgaspot_tariff_links',
    service_repo: 'repositories.service',
    vs_mapper: 'mappers.volgaspot_tariff_links_mapper'
  ]

  root :services

  auto_struct false
  struct_namespace Rapi::Entities

  def additional_service_links_by_user(id)
    tariff_link = find_tariff_link_by_user id
    return [] unless tariff_link

    service_links_data = tariff_link[:service_links_data]
    service_ids = service_links_data.map { |el| el[:id] }
    additional_service_ids = services.additional.by_id(service_ids).ids
    return [] if additional_service_ids.empty?

    service_data = service_repo.additional_services_by_ids additional_service_ids
    service_links = merge_service_data service_links_data, service_data
    service_links.map { |service_link| Volgaspot::ServiceLink.new service_link }
  end

  private

  def merge_service_data(service_links, service_data)
    service_links.map do |service_link|
      service = service_data.find { |sd| sd.id == service_link[:id] }
      next unless service

      service_link[:service] = service
      service_link
    end.compact
  end

  # TODO: find a way for mapper to skip empty values and call it here
  def find_tariff_link_by_user(id)
    raw_tuple = volgaspot_tariff_links.base.by_user(id).one
    return false if raw_tuple[:services].empty?

    vs_mapper.call([raw_tuple]).first
  end
end
