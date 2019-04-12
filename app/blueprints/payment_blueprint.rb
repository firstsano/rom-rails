class PaymentBlueprint < ::Blueprinter::Base
  identifier :id

  fields :user_id, :account_id, :uniq_id, :amount,
         :email, :token, :payment_method, :payment_id,
         :ext_payment_id, :ext_payment_status,
         :status, :is_paying, :need_sync

  field :ext_payment_date, datetime_format: I18n.t('date.formats.full_time_concise')
end
