module Volgaspot
  class TariffsRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_tariffs) do
      attribute :id, ::Types::Int
      attribute :active_tariff_link, ::Types::Coercible::Hash.schema(
        id: ::Types::Strict::Int,
        tariff_id: ::Types::Strict::Int,
        discount_period_id: ::Types::Strict::Int,
        link_date: ::Types::Int
      )
      attribute :services, ::Types::Constructor(Array) do |services|
        services.empty? ? [] : services.values
      end

      primary_key :id
    end

    def by_user(id)
      with_path(id.to_s)
    end

    def base
      with_base_path('users')
        .add_params(expand: 'active_tariff_link,services')
    end
  end
end
