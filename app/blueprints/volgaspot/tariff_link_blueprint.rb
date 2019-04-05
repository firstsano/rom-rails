module Volgaspot
  class TariffLinkBlueprint < ::Blueprinter::Base
    identifier :id

    fields :name, :description, :cost, :cost_per_day,
           :link_with_admin_confirm, :speed, :link_id

    # TODO: add format for date time:
    # field :link_date, datetime_format: "%m/%d/%Y"
    field :link_date

    association :service_links,
                name: :services,
                blueprint: Volgaspot::ServiceLinkBlueprint
  end
end
