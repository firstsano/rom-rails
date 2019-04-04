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

  attribute :ext_payment, ::Types::Strict::Hash.schema(
    id: ::Types::Strict::String,
    status: ::Types::Strict::String,
    paid: ::Types::Strict::Bool,
    payment_method: ::Types::Strict::Hash,
    created_at: ::Types::Form::DateTime,
    test: ::Types::Strict::Bool,

    amount: ::Types::Hash.schema(
      value: ::Types::Form::Float,
      currency: ::Types::String
    ),

    confirmation: ::Types::Coercible::Hash.schema(
      type: ::Types::Strict::String,
      enforce: ::Types::Bool.optional,
      return_url: ::Types::String.optional,
      confirmation_url: ::Types::String.optional
    ).default({}),

    cancellation_details: ::Types::Coercible::Hash.schema(
      party: ::Types::Strict::String,
      reason: ::Types::Strict::String
    ).default({}),

    authorization_details: ::Types::Coercible::Hash.schema(
      rrn: ::Types::Strict::String,
      auth_code: ::Types::Strict::String
    ).default({}),

    description: ::Types::String.optional,
    captured_at: ::Types::Form::DateTime.optional,
    expires_at: ::Types::Form::DateTime.optional,
    metadata: ::Types::Coercible::Hash.default({})
  )
end
