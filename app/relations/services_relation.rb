class ServicesRelation < ::ROM::Relation[:sql]
  gateway :utm

  schema(:services_data, infer: true, as: :services) do
    attribute :is_deleted, Types::Bool

    associations do
      belongs_to :services, as: :parent, foreign_key: :parent_service_id
    end
  end

  def active
    where { is_deleted.is(0) }
  end
end
