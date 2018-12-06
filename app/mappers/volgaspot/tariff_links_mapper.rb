module Volgaspot
  class TariffLinksMapper < ROM::Mapper
    relation :volgaspot_tariff_links

    register_as :volgaspot_tariff_links_mapper

    model OpenStruct
    attribute :id
    unwrap :active_tariff_link do
      attribute :tariff_id
    end

    embedded :services, type: :array do
      model OpenStruct
      attribute :id, from: :service_id
    end
  end
end
