module Volgaspot
  class PromisedPaymentsMapper < ROM::Mapper
    relation :volgaspot_promised_payments

    register_as :volgaspot_promised_payments_mapper

    model OpenStruct

    attribute(:last_promised_payment_date) do |timestamp|
      Time.at(timestamp).to_datetime if timestamp and (timestamp > 0)
    end
  end
end
