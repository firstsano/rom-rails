class TariffRepository < ROM::Repository::Root
  root :tariffs

  auto_struct false
  struct_namespace Rapi::Entities

  def by_user(id)
    tariff_link = find_tariff_link_by_user id
    service_ids = tariff_link.services.map(&:id)
    get_tariffs_with_services(tariff_link.tariff_id, service_ids).to_a
  end

  private

  def get_tariffs_with_services(tariffs_ids, services_ids)
    return [] unless tariffs_ids

    tariffs.by_id(tariffs_ids).map_with(:tariffs_mapper).combine(services: :parent)
           .node(:services) { |services| services.main.by_id(services_ids) }
  end

  def find_tariff_link_by_user(id)
    volgaspot_tariff_links.base.map_with(:volgaspot_tariff_links_mapper).by_user(id).one!
  end

  def volgaspot_tariff_links
    ROM.env.relations[:volgaspot_tariff_links]
  end
end
