class BalanceOperationBlueprint < Blueprinter::Base
  identifier :id

  fields :type, :balance_before, :sum, :balance,
         :operation_id, :operation_name

  field :time, datetime_format: I18n.t('date.formats.full_time_concise')
end
