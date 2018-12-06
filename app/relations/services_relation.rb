class ServicesRelation < ::ROM::Relation[:sql]
  gateway :utm

  NO_TARIFF_ID = 0

  schema(:services_data, infer: true, as: :services) do
    attribute :cost, ::Types::Float.meta(qualified: :periodic_services_data)
  end

  dataset do
    left_join(:periodic_services_data, id: :id)
      .where(is_deleted: 0)
      .qualify
      .select_append(:cost)
  end

  def by_id(required_id)
    where { id =~ required_id }
  end

  def additional
    where { tariff_id.is(NO_TARIFF_ID) }
  end

  def main
    where { !tariff_id.is(NO_TARIFF_ID) }
  end
end
