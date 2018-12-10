module Volgaspot
  class TariffLinksRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_tariff_links) do
      attribute :id, ::Types::Int
      attribute :active_tariff_link, ::Types::Hash.schema(
        id: ::Types::Strict::Int,
        tariff_id: ::Types::Strict::Int,
        discount_period_id: ::Types::Strict::Int,
        link_date: ::Types::Int
      )
      attribute :services, ::Types::Constructor(Array, &:values)

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
