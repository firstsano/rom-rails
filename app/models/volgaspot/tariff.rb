module Volgaspot
  class Tariff < ::ROM::Struct
    attribute :discount_period_id, ::Types::Strict::Int
    attribute :link_id, ::Types::Strict::Int
    attribute :link_date, ::Types::Int
    attribute :tariff, ::Tariff
    attribute :services, ::Types::Strict::Array.of(Volgaspot::Service).default([])

    delegate :id, :name, :cost, :cost_per_day, :description, to: :tariff

    def cost
      services.inject(0) { |sum, service| sum + service.cost }
    end

    def cost_per_day
      current_month = Time.now.month
      (cost / Time.days_in_month(current_month)).round(2)
    end
  end
end