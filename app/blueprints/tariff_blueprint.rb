class TariffBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description, :cost

  association :services, blueprint: ServiceBlueprint
end
