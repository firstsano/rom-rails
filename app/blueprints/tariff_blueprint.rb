class TariffBlueprint < ::Blueprinter::Base
  identifier :id

  fields :name, :description, :cost, :cost_per_day,
         :link_with_admin_confirm, :speed

  association :services, blueprint: ServiceBlueprint
end
