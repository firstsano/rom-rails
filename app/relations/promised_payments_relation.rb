class PromisedPaymentsRelation < ::ROM::Relation[:http]
  gateway :volgaspot

  schema(:promised_payments) do
    attribute :available, ::Types::Bool
    attribute :last_promised_payment_date, ::Types::DateTime.optional
  end

  def by_user(id)
    with_path("#{id}/promised-payment-status")
  end

  def base
    with_base_path('users')
  end
end
