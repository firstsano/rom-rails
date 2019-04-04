module Volgaspot
  class PaymentsRelation < ::ROM::Relation[:http]
    gateway :volgaspot
    auto_map false

    schema(:volgaspot_payments) do
      attribute :id, ::Types::Strict::String
      primary_key :id
    end

    def by_id(id)
      with_path id.to_s
    end

    def base
      with_base_path('invoices?expand=payment,ext_payment')
    end
  end
end
