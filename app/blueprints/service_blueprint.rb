class ServiceBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description, :cost, :type, :cost_per_day
end
