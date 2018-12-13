module Volgaspot
  module Tariffs
    class Create < ROM::Commands::Create[:http]
      relation :volgaspot_tariffs
      register_as :create
      result :one

      def execute(id, tariff_id)
        tariff_params = { tariff_id: tariff_id }
        relation
            .dataset
            .with_base_path('/users')
            .with_path("#{id}/link-tariff")
            .with_options(request_method: :put, params: tariff_params)
            .response
      end
    end
  end
end
