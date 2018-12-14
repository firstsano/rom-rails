class ServiceRepository < ROM::Repository::Root
  include Import['relations.volgaspot_services', 'relations.volgaspot_tariffs']

  root :services

  auto_struct false
  struct_namespace Rapi::Entities

  # TODO: refactor using mapper
  def services_by_user(id)
    tariff_link = find_tariff_link_by_user id
    return [] unless tariff_link

    service_ids = tariff_link.services.map(&:id)
    link_services = services.additional.by_id(service_ids).map_with(:services_mapper).to_a
    merged_hash = tariff_link.to_hash
    service_ids = tariff_link.services.map &:id
    service_types = get_service_types_by_services(service_ids)

    services = link_services.map do |service|
      next unless service_ids.include?(service.id)
      sss = tariff_link.services.select { |s| s.id == service.id }
      type = service_types.select { |service_type| service_type[:utm5_service_id] == service.id }
      ss = service.to_hash.merge(sss.first.to_hash).merge(type.first)
      ss.merge({service: ss})
    end.compact
    merged_hash[:services] = services
    merged_hash[:services].map { |s|  Volgaspot::Service.new(s) }
  end

  private

  # TODO: find a way for mapper to skip empty values and call it here
  def find_tariff_link_by_user(id)
    raw_tuple = volgaspot_tariffs
                    .base.by_user(id)
                    .one
    return false if raw_tuple[:services].empty?

    tuple = volgaspot_tariffs.mappers[:volgaspot_tariffs_mapper].call([raw_tuple]).first
    RecursiveOpenStruct.new tuple, recurse_over_arrays: true
  end

  def get_service_types_by_services(service_ids)
    volgaspot_services.base.by_id(service_ids).map_with(:volgaspot_services_mapper).to_a
  end

  def get_tariff_with_services(service_ids)
    services.main.by_id(service_ids).map_with(:tariffs_mapper).to_a
  end
end
