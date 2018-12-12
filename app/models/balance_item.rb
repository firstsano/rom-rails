class BalanceItem < ::ROM::Struct
  constructor_type :schema

  attribute :date, ::Types::Date
  attribute :operations, ::Types::Strict::Array.of(BalanceOperation)

  def balance
    recent_operation.balance
  end

  private

  def recent_operation
    operations
      .sort_by(&:time)
      .reverse
      .first
  end
end
