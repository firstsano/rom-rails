module Volgaspot
  class ServicesMapper < ROM::Mapper
    relation :volgaspot_services

    register_as :volgaspot_services_mapper

    step do
      unwrap :type do
        attribute :type_name, from: :name
      end
    end

    step do
      attribute :type, from: :type_sid
    end
  end
end
