class ServiceRepository < ROM::Repository::Root
  root :services

  auto_struct false
  struct_namespace Rapi::Entities

  def by_user(id)
    tariff_link = find_tariff_link_by_user id
    service_ids = tariff_link.services.map(&:id)
    services.additional.by_id(service_ids).map_with(:services_mapper).to_a
  end

  private

  def find_tariff_link_by_user(id)
    volgaspot_tariff_links.base.map_with(:volgaspot_tariff_links_mapper).by_user(id).one!
  end

  def volgaspot_tariff_links
    ROM.env.relations[:volgaspot_tariff_links]
  end
end
