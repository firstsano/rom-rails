module Volgaspot
  class PaymentsRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_payments) do
      attribute :id, ::Types::String
      attribute :status, ::Types::String
      attribute :paid, ::Types::Bool
      attribute :amount, ::Types::Strict::Hash.schema(
        attribute :value, ::Types::String
        attribute :currency, ::Types::String
      )
      attribute :confirmation, ::Types::Coercible::Hash.schema(
        attribute :type, ::Types::Strict::String
        attribute :enforce, ::Types::Bool.optional
        attribute :return_url, ::Types::String.optional
        attribute :confirmation_url, ::Types::String.optional
      )
      attribute :created_at, ::Types::Form::DateTime
      attribute :description, ::Types::String
      attribute :metadata, ::Types::Coercible::Hash
      attribute :payment_method, ::Types::Strict::Hash.schema(
        attribute :type, ::Types::Strict::String
        attribute :id, ::Types::Strict::String
        attribute :saved, ::Types::Strict::Bool
        attribute :title, ::Types::String
        attribute :login, ::Types::Strict::String
      )
      attribute :test, ::Types::Bool

      primary_key :id
    end
  end
end
