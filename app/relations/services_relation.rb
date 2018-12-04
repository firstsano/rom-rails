class ServicesRelation < ::ROM::Relation[:sql]
  gateway :utm

  schema(:services_data, infer: true, as: :services) do
    attribute :cost, Types::Float.meta(qualified: :periodic_services_data)

    associations do
      belongs_to :services, as: :parent, foreign_key: :parent_service_id
    end
  end

  dataset do
    select(:cost)
      .left_join(:periodic_services_data, id: :id)
      .where(is_deleted: 0)
      .qualify
  end
end
