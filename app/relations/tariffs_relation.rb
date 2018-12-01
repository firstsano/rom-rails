class TariffsRelation < ::ROM::Relation[:sql]
  gateway :utm

  schema(:tariffs) do
    attribute :id, Types::Serial
    attribute :name, Types::Strict::String
    attribute :create_date, Types::Int
    attribute :change_date, Types::Int
    attribute :comments, Types::Strict::String
  end

  dataset do
    where(is_deleted: 0).order(:id)
  end

  def by_id(id)
    where(id: id)
  end

  def for_users(users)
    where(id: users.map do |user|
      user[:active_tariff_link][:tariff_id]
    end)
  end
end
