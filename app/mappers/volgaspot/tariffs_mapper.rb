module Volgaspot
  class TariffsMapper < ROM::Mapper
    relation :volgaspot_tariffs

    register_as :volgaspot_tariffs_mapper

    step do
      exclude :id
      attribute :tariff, from: :active_tariff_link
    end

    step do
      embedded :tariff, type: :hash do
        attribute :link_id, from: :id
        attribute :id, from: :tariff_id
        attribute :link_date
      end
    end

    step do
      embedded :services, type: :array do
        attribute :id, from: :service_id
        attribute :name, from: :service_name
        attribute :link_id, from: :service_link_id

        exclude :tariff_name
        exclude :service_cost
        exclude :discount_period_id
      end
    end

    step do
      ungroup :services do
        attribute :id
        attribute :name
        attribute :type
      end
    end

    step do
      attribute(:link_ids, from: :services) { |service| service.map { |s| s[:link_id] } }
    end

    step do
      group :services do
        attribute :id
        attribute :name
        attribute :type
        attribute :link_ids
      end
    end
  end
end
