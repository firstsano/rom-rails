class BalanceOperationsMapper < ROM::Mapper
  relation :balance_operations

  register_as :balance_operations

  copy_keys true

  step do
    embedded :operations, type: :array do
      attribute(:date, from: :discount_date) { |timestamp| Time.at(timestamp).to_date }
    end
  end

  step do
    ungroup :operations do
      attribute :date
    end
  end

  step do
    embedded :operations, type: :array do
      attribute(:sum, from: :discount) { |value| value.abs.round(2) }
      attribute(:time, from: :discount_date) { |timestamp| Time.at(timestamp).to_datetime }
      attribute(:balance_before, from: :incoming_rest) { |value| value.round(2) }
      attribute(:balance, from: :outgoing_rest) { |value| value.round(2) }
    end
  end

  step do
    embedded :operations, type: :array do
      exclude :incoming_rest
      exclude :outgoing_rest
      exclude :discount_with_tax
      exclude :discount_period_id
      exclude :slink_id
      exclude :discount
      exclude :discount_date
    end
  end

  step do
    model BalanceItem
    embedded :operations, type: :array do
      model BalanceOperation
    end
  end
end
