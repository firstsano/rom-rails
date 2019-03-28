class Service < ::ROM::Struct
  constructor_type :schema

  attribute :id, ::Types::Strict::Int
  attribute :name, ::Types::Strict::String
  attribute :type, ::Types::String
  attribute :type_name, ::Types::String
  attribute :description, ::Types::Strict::String
  attribute :cost, ::Types::Strict::Float

  # TODO: use service's discount period to count
  # number of days instead of suppose that it is
  # a month
  def cost_per_day
    current_month = Time.now.month
    (cost / Time.days_in_month(current_month)).round(2)
  end
end
