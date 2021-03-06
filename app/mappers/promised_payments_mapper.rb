class PromisedPaymentsMapper < ROM::Mapper
  relation :promised_payments

  register_as :promised_payments_mapper

  model OpenStruct

  attribute(:last_promised_payment_date) do |timestamp|
    Time.at(timestamp).to_datetime if timestamp&.positive?
  end
end
