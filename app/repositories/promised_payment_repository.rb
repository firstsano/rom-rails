class PromisedPaymentRepository < ROM::Repository::Root
  root :promised_payments

  # Though it's not necessary for current version of
  # rom-http, the behaviour will change in future, and
  # it's better to use `auto_struct false` now
  auto_struct false
  struct_namespace Rapi::Entities

  def status_by_user(id)
    promised_payments
      .base
      .map_with(:promised_payments_mapper)
      .by_user(id)
      .one
  end

  def create_promised_payment_for_user(id)
    response = promised_payments.command(:create).call id
    response[:success] and response[:data]
  end
end

