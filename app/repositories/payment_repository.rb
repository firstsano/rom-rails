class PaymentRepository < ROM::Repository::Root
  root :volgaspot_payments

  struct_namespace Rapi::Entities

  def payment_by_id(id)
    volgaspot_payments.by_id(id).one
  end

  def create_payment_for_user(id)
    response = volgaspot_payments.command(:create).call id
    response[:success] and response[:data]
  end
end
