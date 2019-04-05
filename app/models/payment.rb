class Payment < ::ROM::Struct
  PAYMENT_METHOD_YANDEX = 111

  constructor_type :schema

  attribute :id, ::Types::Int
  attribute :user_id, ::Types::Int
  attribute :account_id, ::Types::Int
  attribute :uniq_id, ::Types::String
  attribute :amount, ::Types::Form::Float
  attribute :payment_method, ::Types::Int
  attribute :ext_payment_id, ::Types::String
  attribute :ext_payment_status, ::Types::String
  attribute :ext_payment_date, ::Types::Form::DateTime
  attribute :status, ::Types::String

  attribute :ext_payment, ::Types::Strict::Hash
end
