class PaymentRepository < ROM::Repository::Root
  root :volgaspot_payments

  auto_struct false
  struct_namespace Rapi::Entities

  def payment_by_id(id)
    root.by_id(id).one
  end

  def create_payment_for_account(account, token, amount)
    root.map_to(Payment).command(:create).call account, token, amount
  end
end
