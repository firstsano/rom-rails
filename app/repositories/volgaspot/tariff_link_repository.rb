module Volgaspot
  class TariffLinkRepository < ROM::Repository::Root
    root :volgaspot_tariff_links

    # Though it's not necessary for current version of
    # rom-http, a behaviour will change in future, and
    # it's better to use `auto_struct false` now
    auto_struct false
    struct_namespace Rapi::Entities

    SERVICE_WITHOUT_TARIFF = "No".freeze

    def by_user(id)
      tariff_link = find_tariff_link_by_user id
      tariff_id = tariff_link.dig :active_tariff_link, :tariff_id
      service_ids = (tariff_link[:services]&.values || [])
                    .select(&services_with_tariffs_selector)
                    .map { |service| service[:service_id] }
      get_tariffs_with_services(tariff_id, service_ids).to_a
    end

    private

    def get_tariffs_with_services(tariffs_ids, services_ids)
      tariffs.by_id(tariffs_ids).map_with(:tariffs_mapper).combine(services: :parent)
             .node(:services) { |services| services.by_id(services_ids) }
    end

    def find_tariff_link_by_user(id)
      volgaspot_tariff_links.base.with_services.by_user(id).one!
    end

    def tariffs
      ROM.env.relations[:tariffs]
    end

    def services_with_tariffs_selector
      proc { |service| service[:tariff_name] != SERVICE_WITHOUT_TARIFF }
    end
  end
end
