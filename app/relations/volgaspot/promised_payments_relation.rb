module Volgaspot
  class PromisedPaymentsRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_promised_payments) do
      attribute :available, ::Types::Bool
      attribute :last_promised_payment_date,
        ::Types::Constructor(DateTime) { |timestamp| Time.at(timestamp).to_datetime }
    end

    def by_user(id)
      with_path("#{id}/promised-payment-status")
    end

    def base
      with_base_path('users')
    end
  end
end
