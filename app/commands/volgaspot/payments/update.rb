module Volgaspot
  module Payments
    class Update < ROM::Commands::Update[:http]
      relation :volgaspot_payments
      register_as :update
      result :one

      def execute(id)
        relation.base_by_id(id)
                .with_options(request_method: :put)
                .dataset
                .response
      end
    end
  end
end
