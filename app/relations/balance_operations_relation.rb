class BalanceOperationsRelation < ::ROM::Relation[:sql]
  gateway :utm

  schema(:discount_transactions_all, infer: true, as: :balance_operations)

  dataset do
    services_data = Sequel[:services_data]
    payment_transactions = Sequel[:payment_transactions]
    discount_transactions_all = Sequel[:discount_transactions_all]
    payment_methods = Sequel[:payment_methods]
    left_join(:payment_transactions, payment_enter_date: :discount_date)
      .left_join(:payment_methods, id: payment_transactions[:method])
      .left_join(:services_data, id: discount_transactions_all[:service_id])
      .qualify
      .select_append { services_data[:service_name].as(:service_name) }
      .select_append { [payment_methods[:name].as(:payment_method), payment_methods[:id].as(:payment_method_id)] }
      .order { id.desc }
  end

  def by_account(id)
    where { account_id =~ id }
  end

  def within(from, to)
    where { (discount_date > from) & (discount_date < to) }
  end
end
