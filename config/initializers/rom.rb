ROM::Rails::Railtie.configure do |config|
  config.gateways[:utm] = [:sql, ENV.fetch('utm')]
end