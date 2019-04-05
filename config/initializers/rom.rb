ROM::Rails::Railtie.configure do |config|
  config.gateways[:utm] = [:sql, ENV.fetch('utm')]

  config.gateways[:volgaspot] = [:http, {
    uri: ENV.fetch('volgaspot_api'),
    headers: {
      Accept: 'application/json',
      'Content-Type' => 'application/json'
    },
    request_handler: Gateways::Volgaspot::RequestHandler.new,
    response_handler: Gateways::Volgaspot::ResponseHandler.new
  }]
end
