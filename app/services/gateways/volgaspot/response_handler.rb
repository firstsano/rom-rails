require 'json'

module Gateways
  module Volgaspot
    class ResponseHandler
      include ::Exceptions::RemoteServer

      def call(response, dataset)
        guard_from_invalid_request response

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        if %i[post put patch].include?(dataset.request_method)
          # parsed_response = parsed_response[:data] unless parsed_response[:data].nil?
          setup_response parsed_response
        else
          raise Request::Unsuccessful, parsed_response[:data][:message] unless parsed_response[:success]

          setup_response parsed_response[:data]
        end
      end

      private

      def guard_from_invalid_request(response)
        not_found_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_found]
        raise Request::NotFound, $ERROR_INFO if response.code.to_i == not_found_code

        raise Request::Error, $ERROR_INFO unless response&.body

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        raise Request::Unsuccessful, parsed_response[:data] if response.code.to_i >= 400
      end

      # Process edge cases:
      #   1. Returned data is a hash with keys as service ids,
      #      which can't be processed automatically by mapper
      def setup_response(response)
        response = response.values if unprocessable_hash?(response)
        Array([response]).flatten
      end

      def unprocessable_hash?(hash)
        return false unless hash.is_a?(Hash)

        hash.keys.map { |key| Integer(key.to_s) }
        true
      rescue
        false
      end
    end
  end
end
