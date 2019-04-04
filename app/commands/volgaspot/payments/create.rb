module Volgaspot
  module Payments
    class Create < ROM::Commands::Create[:http]
      relation :volgaspot_payments
      register_as :create
      result :one

      def execute(account, token, amount)
        payment_params = payment_params account, token, amount
        relation.base.with_options(request_method: :post)
                .add_params(payment_params).dataset
                .response
      end

      def payment_params(account, token, amount)
        payment_options = {
          account_id: account,
          payment_token: token,
          amount: amount
        }
        payment_options
          .merge(payment_method)
          .merge(immediate_update)
      end

      def payment_method
        { payment_method: Payment::PAYMENT_METHOD_YANDEX }
      end

      def immediate_update
        { with_update_status: 1 }
      end
    end
  end
end
