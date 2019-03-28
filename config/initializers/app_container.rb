require 'app_container'

AppContainer.configure do |container|
  container.register('persistence') do
    ROM.env
  end

  container.register('relations.available_tariffs') do
    container['persistence'].relations[:available_tariffs]
  end

  container.register('relations.services') do
    container['persistence'].relations[:services]
  end

  container.register('relations.tariffs') do
    container['persistence'].relations[:tariffs]
  end

  container.register('relations.volgaspot_tariff_links') do
    container['persistence'].relations[:volgaspot_tariff_links]
  end

  container.register('relations.volgaspot_tariffs') do
    container['persistence'].relations[:volgaspot_tariffs]
  end

  container.register('relations.volgaspot_services') do
    container['persistence'].relations[:volgaspot_services]
  end

  container.register('relations.discount_intervals') do
    container['persistence'].relations[:discount_intervals]
  end

  container.register('repositories.service') do
    ServiceRepository.new container['persistence']
  end

  container.register('repositories.tariff') do
    TariffRepository.new container['persistence']
  end

  container.register('repositories.service_link') do
    ServiceLinkRepository.new container['persistence']
  end

  container.register('mappers.volgaspot_tariff_links_mapper') do
    container['relations.volgaspot_tariff_links']
      .mappers[:volgaspot_tariff_links_mapper]
  end

  container.register('mappers.volgaspot_services_mapper') do
    container['relations.volgaspot_services']
      .mappers[:volgaspot_services_mapper]
  end

  container.register('mappers.tariffs_mapper') do
    container['relations.tariffs'].mappers[:tariffs_mapper]
  end

  container.register('mappers.services_mapper') do
    container['relations.services'].mappers[:services_mapper]
  end
end

Import = Dry::AutoInject(AppContainer.instance)
