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

  username = ENV.fetch('yandex_till_username')
  password = ENV.fetch('yandex_till_password')
  config.gateways[:yandex_till] = [:http, {
    uri: ENV.fetch('yandex_till_api'),
    headers: {
      Accept: 'application/json',
      'Content-Type' => 'application/json',
    },
    request_handler: Gateways::YandexTill::RequestHandler.new(username, password),
    response_handler: Gateways::YandexTill::ResponseHandler.new
  }]
end
