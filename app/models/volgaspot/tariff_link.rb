module Volgaspot
  class TariffLink < ::ROM::Struct
    attribute :discount_period_id, ::Types::Strict::Int
    attribute :link_id, ::Types::Strict::Int
    attribute :link_date, ::Types::Int
    attribute :tariff, ::Tariff
    attribute :service_links_data, ::Types::Hash

    delegate :id, :name, :cost, :cost_per_day, :description,
             :link_with_admin_confirm, :speed, :services, to: :tariff

    def service_links
      @service_links ||= generate_service_links
    end

    private

    def generate_service_links
      service_links_data.map do |link_info|
        service = services.find { |s| s.id == link_info[:id] }
        next unless service

        link = { **link_info, service: service }
        Volgaspot::ServiceLink.new link
      end.compact
    end
  end
end
