require 'json'

module Gateways
  module YandexTill
    class ResponseHandler
      include ::Exceptions::RemoteServer

      # def call(response, dataset)
      def call(response)
        guard_from_invalid_request response

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        setup_response parsed_response
      end

      private

      def guard_from_invalid_request(response)
        raise Request::Error, $ERROR_INFO unless response&.body

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        error_message = "#{parsed_response[:code]}: #{parsed_response[:description]}"
        raise Request::Unsuccessful, error_message if response.code.to_i >= 400
      end

      def setup_response(response)
        Array([response]).flatten
      end
    end
  end
end
