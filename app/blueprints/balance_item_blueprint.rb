class BalanceItemBlueprint < Blueprinter::Base
  field :date, datetime_format: I18n.t('date.formats.date_month_year_concise')
  field :balance

  association :operations, blueprint: BalanceOperationBlueprint
end
