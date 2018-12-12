module PromisedPayments
  class Create < ROM::Commands::Create[:http]
    relation :volgaspot_promised_payments
    register_as :create
    result :one

    def execute(id)
      relation
          .dataset
          .with_base_path('/users')
          .with_path("#{id}/use-promised-payment")
          .with_options(request_method: :put)
          .response
    end
  end
end
