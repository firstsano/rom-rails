class ServiceBlueprint < ::Blueprinter::Base
  identifier :id

  fields :name, :description, :cost, :cost_per_day,
         :type, :type_name
end
