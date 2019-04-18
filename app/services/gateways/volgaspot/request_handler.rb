require 'dry/inflector'
require 'dry/initializer'
require 'uri'
require 'net/http'

module Gateways
  module Volgaspot
    class RequestHandler
      extend Dry::Initializer
      include ::Exceptions::RemoteServer

      option :inflector, default: proc { Dry::Inflector.new }

      def call(dataset)
        uri = dataset.uri
        method = inflector.classify dataset.request_method

        http = Net::HTTP.new uri.host, uri.port
        http.use_ssl = (uri.scheme == 'https')
        request_klass = Net::HTTP.const_get method
        request = request_klass.new uri

        authenticate request

        dataset.headers.each_with_object(request) do |(header, value), req|
          req[header.to_s] = value
        end

        if %i[post put patch].include?(dataset.request_method)
          request.body = dataset.params.to_json
        end

        begin
          http.request(request)
        rescue StandardError
          raise Request::Error, $ERROR_INFO
        end
      end

      private

      def authenticate(request)
        request
      end
    end
  end
end
