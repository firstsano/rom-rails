class PaymentRepository < ROM::Repository::Root
  root :yandex_till_payments

  struct_namespace Rapi::Entities
  auto_struct false

  def payment_by_id(id)
    root.by_id(id).one
  end

  def create_payment_for_user(user_id, payment_params)
    root.map_to(Payment).command(:create).call user_id, payment_params
  end
end
