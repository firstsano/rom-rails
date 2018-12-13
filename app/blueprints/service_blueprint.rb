class ServiceBlueprint < Blueprinter::Base
  identifier :id

  fields :name,:description, :cost, :cost_per_day

  view :with_type do
    field :type
  end
end
