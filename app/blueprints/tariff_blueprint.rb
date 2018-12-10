class TariffBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description, :cost, :cost_per_day

  association :services, blueprint: ServiceBlueprint
end
