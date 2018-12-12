class PromisedPaymentRepository < ROM::Repository::Root
  root :volgaspot_promised_payment_statuses

  struct_namespace Rapi::Entities

  def status_by_user(id)
    volgaspot_promised_payment_statuses
      .base
      .by_user(id)
      .one
  end
end
