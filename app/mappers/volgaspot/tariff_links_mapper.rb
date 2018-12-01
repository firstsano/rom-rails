module Volgaspot
  class TariffLinksMapper < ROM::Mapper
    relation :volgaspot_tariff_links

    register_as :volgaspot_tariff_links_mapper

    reject_keys true

    attribute :id
    attribute :name
    attribute :description
  end
end