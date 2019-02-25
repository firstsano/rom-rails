module Volgaspot
  module Payments
    class Create < ROM::Commands::Create[:http]
      relation :volgaspot_payments
      register_as :create
      result :one

      def execute(payment_token, idempotency_key, value, options = {})
        payment_params = {
          payment_token: payment_token,
          idempotency_key: idempotency_key,
          value: value
        }
        relation
          .dataset
          .with_base_path('/payments')
          .with_options(
            request_method: :put,
            params: payment_params.merge(options)
          )
          .response
      end
    end
  end
end
