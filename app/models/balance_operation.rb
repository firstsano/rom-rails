class BalanceOperation < ::ROM::Struct
  constructor_type :schema

  attribute :id, ::Types::Int
  attribute :time, ::Types::DateTime
  attribute :balance_before, ::Types::Float
  attribute :balance, ::Types::Float
  attribute :sum, ::Types::Float
  attribute :service_id, ::Types::Int
  attribute :service_type, ::Types::Int
  attribute :service_name, ::Types::String
  attribute :charge_type, ::Types::Int
  attribute :payment_method, ::Types::String
  attribute :payment_method_id, ::Types::Int

  def type
    if payment_method.present?
      :payment
    else
      :discount
    end
  end

  def operation_name
    if type == :payment
      payment_method
    else
      service_name
    end
  end

  def operation_id
    if type == :payment
      payment_method_id
    else
      service_id
    end
  end
end
