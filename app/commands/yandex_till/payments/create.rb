module YandexTill
  module Payments
    class Create < ROM::Commands::Create[:http]
      relation :yandex_till_payments
      register_as :create
      result :one

      def execute(user_id, payment_params)
        payment_params[:description] = "Payment for user \##{user_id}"
        idempotence_key = payment_params.delete(:idempotence_key)
        relation.base
                .dataset
                .with_headers('Idempotence-Key' => idempotence_key)
                .with_options(
                  request_method: :post,
                  params: payment_params
                )
                .response
      end
    end
  end
end
