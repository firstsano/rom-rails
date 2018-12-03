class TariffsRelation < ::ROM::Relation[:sql]
  gateway :utm

  schema(:tariffs, infer: true) do
    associations do
      has_many :services_tariffs
      has_many :services, through: :services_tariffs, view: :active
    end
  end

  dataset do
    where(is_deleted: 0).order(:id)
  end

  def by_id(id)
    where(id: id)
  end
end
