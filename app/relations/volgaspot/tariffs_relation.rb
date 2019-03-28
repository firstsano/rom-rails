module Volgaspot
  class TariffsRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_tariffs) do
      attribute :id, ::Types::Strict::Int
      attribute :link_with_admin_confirm, ::Types::Form::Bool
      attribute :speed, ::Types::Coercible::String

      primary_key :id
    end

    def by_ids(ids)
      add_params 'id' => Array(ids).to_s
    end

    def base
      with_base_path 'tariffs'
    end
  end
end
