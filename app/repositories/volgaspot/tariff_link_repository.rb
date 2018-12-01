module Volgaspot
  class TariffLinkRepository < ROM::Repository::Root
    root :volgaspot_tariff_links

    # Though it's not necessary for current version of
    # rom-http, a behaviour will change in future, and
    # it's better to use `auto_struct false` now
    auto_struct false
    struct_namespace Rapi::Entities

    def find_by_user(id)
      tariff_link = volgaspot_tariff_links.by_user(id).one!
      tariff_id = tariff_link.dig :active_tariff_link, :tariff_id
      tariff = tariffs.map_with(:tariffs_mapper).by_id(tariff_id).one
      mapper.call([tariff]).first
    end

    private

    def mapper
      volgaspot_tariff_links.mappers[:volgaspot_tariff_links_mapper]
    end

    def tariffs
      ROM.env.relations[:tariffs]
    end
  end
end
