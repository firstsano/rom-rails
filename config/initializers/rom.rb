require 'gateways/volgaspot/request_handler'
require 'gateways/volgaspot/response_handler'


ROM::Rails::Railtie.configure do |config|
  config.gateways[:utm] = [:sql, ENV.fetch('utm')]
  config.gateways[:volgaspot] = [:http, {
      uri: ENV.fetch('volgaspot_api'),
      headers: {
          Accept: 'application/json'
      },
      request_handler: RequestHandler.new,
      response_handler: ResponseHandler.new
  }]
end