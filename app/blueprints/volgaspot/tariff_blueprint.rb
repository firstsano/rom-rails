module Volgaspot
  class TariffBlueprint < ::TariffBlueprint
    field :link_id
    # TODO: add format for date time:
    # field :link_date, datetime_format: "%m/%d/%Y"
    field :link_date

    association :services, blueprint: Volgaspot::ServiceBlueprint
  end
end
