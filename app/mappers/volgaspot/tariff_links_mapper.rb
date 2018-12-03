module Volgaspot
  class TariffLinksMapper < ROM::Mapper
    relation :volgaspot_tariff_links

    register_as :volgaspot_tariff_links_mapper

    reject_keys true

    attribute :id
    attribute :name
    attribute :description

    embedded :services, type: :array do
      attribute :id
      attribute :name, from: :service_name
      attribute(:description, from: :comment) { |desc| Sanitize.fragment desc }

      unwrap :parent do
        attribute :type, from: :service_name
      end
    end
  end
end