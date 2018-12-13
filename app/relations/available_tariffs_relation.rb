class AvailableTariffsRelation < ::ROM::Relation[:http]
  gateway :volgaspot

  schema(:available_tariffs) do
    attribute :id, ::Types::Int

    primary_key :id
  end

  def by_user(id)
    with_path("#{id}/available-tariffs")
  end

  def base
    with_base_path('users')
  end
end
