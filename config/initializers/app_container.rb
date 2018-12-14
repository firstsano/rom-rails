require 'app_container'

AppContainer.configure do |container|
  container.register('persistence') do
    ROM.env
  end

  container.register('persistence.relations.available_tariffs') do
    container['persistence'].relations[:available_tariffs]
  end

  container.register('persistence.relations.services') do
    container['persistence'].relations[:services]
  end

  container.register('persistence.relations.volgaspot_tariffs') do
    container['persistence'].relations[:volgaspot_tariffs]
  end

  container.register('persistence.relations.volgaspot_services') do
    container['persistence'].relations[:volgaspot_services]
  end

  container.register('persistence.relations.discount_intervals') do
    container['persistence'].relations[:discount_intervals]
  end
end

Import = Dry::AutoInject(AppContainer.instance)
