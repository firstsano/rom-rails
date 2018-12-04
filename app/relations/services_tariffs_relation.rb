class ServicesTariffsRelation < ::ROM::Relation[:sql]
  gateway :utm

  schema(:tariffs_services_link, infer: true, as: :services_tariffs) do
    associations do
      belongs_to :tariff
      belongs_to :service, foreign_key: :service_id
    end
  end

  dataset do
    where(is_deleted: 0).qualify
  end
end
