class PaymentRepository < ROM::Repository::Root
  root :volgaspot_payments

  auto_struct false
  struct_namespace Rapi::Entities

  def payment_by_id(id)
    root.by_id(id).one
  end

  def fetch_payment_by_id(id)
    response =  root.command(:update).call id
    return false unless response[:success]

    Payment.new response[:data]
  end

  def create_payment_for_account(account, token, amount)
    response =  root.command(:create).call account, token, amount
    return false unless response[:success]

    Payment.new response[:data]
  end
end
