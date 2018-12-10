module Volgaspot
  class TariffBlueprint < ::TariffBlueprint
    fields :link_id, :link_date

    association :services, blueprint: Volgaspot::ServiceBlueprint
  end
end
