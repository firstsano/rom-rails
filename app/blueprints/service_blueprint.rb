class ServiceBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :type, :description, :cost, :cost_per_day
end
