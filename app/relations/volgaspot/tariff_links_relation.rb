module Volgaspot
  class TariffLinksRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_tariff_links) do
      attribute :id, Types::Int
      attribute :active_tariff_link, Types::Hash.schema(
        tariff_id: Types::Strict::Int,
        discount_period_id: Types::Strict::Int,
        link_date: Types::Int
      )

      primary_key :id
    end

    def by_user(id)
      with_base_path('users')
        .add_params(expand: 'active_tariff_link')
        .with_path(id.to_s)
    end
  end
end
