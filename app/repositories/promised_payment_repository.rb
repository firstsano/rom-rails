class PromisedPaymentRepository < ROM::Repository::Root
  root :volgaspot_promised_payments

  # Though it's not necessary for current version of
  # rom-http, the behaviour will change in future, and
  # it's better to use `auto_struct false` now
  auto_struct false
  struct_namespace Rapi::Entities

  def status_by_user(id)
    volgaspot_promised_payments
      .base
      .map_with(:volgaspot_promised_payments_mapper)
      .by_user(id)
      .one
  end

  def create_promised_payment_for_user(id)
    volgaspot_promised_payments.command(:create).call id
  end
end

