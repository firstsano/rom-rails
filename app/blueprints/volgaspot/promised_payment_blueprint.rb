module Volgaspot
  class PromisedPaymentBlueprint < Blueprinter::Base
    field :available
    field :last_promised_payment_date,
          name: :last_promised_payment,
          datetime_format: I18n.t('date.formats.full_time_concise')
  end
end
