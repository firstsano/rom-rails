module Volgaspot
  class PaymentsRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_payments) do
      attribute :id, ::Types::Strict::String
      attribute :status, ::Types::Strict::String
      attribute :paid, ::Types::Strict::Bool
      attribute :payment_method, ::Types::Strict::Hash
      attribute :created_at, ::Types::Form::DateTime
      attribute :test, ::Types::Strict::Bool

      attribute :amount, ::Types::Strict::Hash.schema(
        value: ::Types::String,
        currency: ::Types::String
      )

      attribute :confirmation, ::Types::Coercible::Hash.schema(
        type: ::Types::Strict::String,
        enforce: ::Types::Bool.optional,
        return_url: ::Types::String.optional,
        confirmation_url: ::Types::String.optional,
      )

      attribute :cancellation_details, ::Types::Coercible::Hash.schema(
        party: ::Types::Strict::String,
        reason: ::Types::Strict::String
      )

      attribute :authorization_details, ::Types::Coercible::Hash.schema(
        rrn: ::Types::String,
        auth_code: ::Types::String
      )

      attribute :description, ::Types::String.optional
      attribute :captured_at, ::Types::Form::DateTime.optional
      attribute :expires_at, ::Types::Form::DateTime.optional
      attribute :metadata, ::Types::Coercible::Hash

      primary_key :id
    end
  end
end
