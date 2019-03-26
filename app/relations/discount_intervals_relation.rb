class DiscountIntervalsRelation < ::ROM::Relation[:sql]
  include ROM::SQL::Plugin::Pagination

  gateway :utm

  per_page 10

  schema(:discount_transactions_all, as: :discount_intervals) do
    attribute :date_interval, ::Types::Time
  end

  dataset do
    select { to_timestamp(discount_date).cast(:date).cast(:timestamp).as(:date_interval) }
      .distinct
      .order { date_interval.desc }
  end

  def by_account(id)
    where { account_id =~ id }
  end
end
