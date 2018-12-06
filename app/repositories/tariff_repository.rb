class TariffRepository < ROM::Repository::Root
  root :tariffs

  auto_struct false
  struct_namespace Rapi::Entities

  def by_user(id)
    tariff_link = find_tariff_link_by_user id
    tariff_id = tariff_link.dig :active_tariff_link, :tariff_id
    service_ids = (tariff_link[:services]&.values || []).map { |service| service[:service_id] }
    get_tariffs_with_services(tariff_id, service_ids).to_a
  end

  private

  def get_tariffs_with_services(tariffs_ids, services_ids)
    tariffs.by_id(tariffs_ids).map_with(:tariffs_mapper).combine(services: :parent)
           .node(:services) { |services| services.main.by_id(services_ids) }
  end

  def find_tariff_link_by_user(id)
    volgaspot_tariff_links.base.with_services.by_user(id).one!
  end

  def volgaspot_tariff_links
    ROM.env.relations[:volgaspot_tariff_links]
  end
end
