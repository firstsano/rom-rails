require 'dry/inflector'
require 'dry/initializer'
require 'uri'
require 'net/http'

class RequestHandler
  extend Dry::Initializer

  option :inflector, default: proc { Dry::Inflector.new }
  option :base_headers, default: proc { { 'Content-Type': 'application/json' } }

  def call(dataset)
    uri = dataset.uri
    method = inflector.classify dataset.request_method

    http = Net::HTTP.new uri.host, uri.port
    request_klass = Net::HTTP.const_get method
    request = request_klass.new uri.request_uri

    headers = base_headers.merge dataset.headers
    headers.each_with_object(request) do |(header, value), req|
      req[header.to_s] = value
    end

    if %i[post put patch].include?(dataset.request_method)
      request.body = dataset.params.to_json
    end

    begin
      http.request(request)
    rescue StandardError
      raise ::Exceptions::RemoteServer::RequestError, $ERROR_INFO
    end
  end
end
