module Volgaspot
  class PaymentsRelation < ::ROM::Relation[:http]
    gateway :volgaspot
    auto_map false

    schema(:volgaspot_payments) do
      attribute :id, ::Types::Strict::Int
      attribute :user_id, ::Types::Int
      attribute :account_id, ::Types::Int
      attribute :uniq_id, ::Types::String
      attribute :amount, ::Types::Coercible::Float
      attribute :email, ::Types::String
      attribute :token, ::Types::String
      attribute :payment_method, ::Types::Strict::Int
      attribute :payment_id, ::Types::Int
      attribute :ext_payment_id, ::Types::Int
      attribute :ext_payment_status, ::Types::Int
      attribute :ext_payment_date, ::Types::Form::DateTime
      attribute :status, ::Types::Strict::String
      attribute :is_paying, ::Types::Int
      attribute :need_sync, ::Types::Int

      primary_key :id
    end

    def by_id(id)
      with_base_path('invoices').with_path id.to_s
    end

    def base
      with_base_path('invoices?expand=payment,ext_payment')
    end
  end
end
