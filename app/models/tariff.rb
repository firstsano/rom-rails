class Tariff < ::ROM::Struct
  constructor_type :schema

  attribute :id, ::Types::Strict::Int
  attribute :name, ::Types::Strict::String
  attribute :description, ::Types::Strict::String
  attribute :services, ::Types::Strict::Array.of(Service).default([])

  def cost
    services.inject(0) { |sum, service| sum + service.cost }
  end

  def cost_per_day
    current_month = Time.now.month
    (cost / Time.days_in_month(current_month)).round(2)
  end
end
