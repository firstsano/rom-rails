require 'dry/inflector'
require 'dry/initializer'
require 'net/http'


class RequestHandler
  extend Dry::Initializer

  option :inflector, default: proc { Dry::Inflector.new }

  def call(dataset)
    uri = dataset.uri
    method = inflector.classify dataset.request_method

    http = Net::HTTP.new uri.host, uri.port
    request_klass = Net::HTTP.const_get method
    request = request_klass.new uri.request_uri

    dataset.headers.each_with_object(request) do |(header, value), request|
      request[header.to_s] = value
    end

    begin
      response = http.request(request)
    rescue
      raise ::Exceptions::RemoteServer::RequestError, $!
    end
  end
end