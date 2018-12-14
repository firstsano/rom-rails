module Volgaspot
  class ServicesRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_services) do
      attribute :id, ::Types::Strict::Int
      attribute :type_sid, ::Types::String
      attribute :utm5_service_id, ::Types::Strict::Int
      attribute :type, ::Types::Coercible::Hash.schema(
        id: ::Types::Strict::Int,
        name: ::Types::String,
        utm5_type_id: ::Types::Int,
        utm5_template_id: ::Types::Int
      )

      primary_key :id
    end

    def by_id(id)
      add_params('id[]' => id)
    end

    def base
      with_base_path('services')
        .add_params(expand: 'type', scope: 'all')
    end
  end
end
