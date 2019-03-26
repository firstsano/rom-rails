module Volgaspot
  module TariffLinks
    class Delete < ROM::Commands::Delete[:http]
      relation :volgaspot_tariff_links
      register_as :delete
      result :one

      def execute(id)
        relation
          .dataset
          .with_base_path('/users')
          .with_path("#{id}/unlink-tariff")
          .with_options(request_method: :put)
          .response
      end
    end
  end
end
