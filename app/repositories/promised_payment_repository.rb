class PromisedPaymentRepository < ROM::Repository::Root
  root :volgaspot_promised_payments

  struct_namespace Rapi::Entities

  def status_by_user(id)
    volgaspot_promised_payments
      .base
      .by_user(id)
      .one
  end
end
