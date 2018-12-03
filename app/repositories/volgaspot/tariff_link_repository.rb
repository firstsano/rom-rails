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
      tariffs.by_id(tariff_id).one
    end

    private

    def tariffs
      ROM.env.relations[:tariffs]
         .map_with(:tariffs_mapper)
         .combine(services: :parent)
    end
  end
end
