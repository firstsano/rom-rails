module Volgaspot
  class ServiceLinksRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_service_links) do
      attribute :id, ::Types::Int
      attribute :services, ::Types::Constructor(Array) { |hash| hash.values }

      primary_key :id
    end

    def by_user(id)
      with_path(id.to_s)
    end

    def base
      with_base_path('users')
        .add_params(expand: 'services')
    end
  end
end
