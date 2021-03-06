class BalanceOperationRepository < ROM::Repository::Root
  include Import['relations.discount_intervals']

  root :balance_operations

  auto_struct false
  struct_namespace Rapi::Entities

  # TODO: to think if this can be refactored as mapper without first creating an object
  def balance_operations_by_user(id, page:, per_page:)
    required_interval = discount_intervals
                        .by_account(id)
                        .page(page)
                        .per_page(per_page)
                        .to_a
    return [] if required_interval.empty?

    to = required_interval.first[:date_interval].end_of_day.to_i
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
end
