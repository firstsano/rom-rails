class BalanceOperationRepository < ROM::Repository::Root
  root :balance_operations

  auto_struct false
  struct_namespace Rapi::Entities

  # TODO: to think if this can be refactored as mapper without first creating an object
  def balance_operations_by_user(id)
    required_interval = discount_intervals.by_account(id).page(1).to_a
    to = required_interval.first[:date_interval].to_i
    from = required_interval.last[:date_interval].to_i
    load_balance_history id, from, to
  end

  private

  def load_balance_history(account_id, from, to)
    operations = balance_operations.by_account(account_id).within(from, to).to_a
    return [] if operations.empty?

    grouped_operations = { operations: operations }
    balance_operations.mappers[:balance_operations].call [grouped_operations]
  end

  def discount_intervals
    ROM.env.relations[:discount_intervals]
  end
end
