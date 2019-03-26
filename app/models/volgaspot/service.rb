module Volgaspot
  class Service < ::ROM::Struct
    attribute :link_ids, ::Types::Strict::Array.of(::Types::Int)
    attribute :service, ::Service

    delegate :id, :name, :type, :cost, :cost_per_day, :description, to: :service

    def quantity
      link_ids.count
    end
  end
end
