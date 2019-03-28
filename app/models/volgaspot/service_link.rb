module Volgaspot
  class ServiceLink < ::ROM::Struct
    attribute :link_ids, ::Types::Strict::Array.of(::Types::Int)
    attribute :service, ::Service

    delegate :id, :name, :type, :type_name, :cost, :cost_per_day,
             :description, to: :service

    def quantity
      link_ids.count
    end
  end
end
