class TariffRepository < ROM::Repository::Root
  root :tariffs

  auto_struct false
  struct_namespace Rapi::Entities

  def tariffs_by_user(id)
    tariff_link = find_tariff_link_by_user id
    return [] unless tariff_link.tariff

    tariff = get_tariff_with_services tariff_link.tariff.id, tariff_link.services.map(&:id)
    combined_data = merge_tariff_data tariff_link, tariff
    combined_data.map { |s|  Volgaspot::Tariff.new(s) }
  end

  private

  def get_tariff_with_services(tariff_id, service_ids)
    tariffs.by_id(tariff_id).map_with(:tariffs_mapper).combine(:services)
           .node(:services) { |services| services.main.by_id(service_ids) }.one
  end

  # TODO: refactor using mapper
  def merge_tariff_data(link_info, tariff_info)
    merged_hash = link_info.to_hash
    service_ids = tariff_info.services.map &:id
    merged_hash[:tariff].merge!({tariff: tariff_info.to_hash.except!(:services)})
    services = link_info.services.map do |service|
      next unless service_ids.include?(service.id)
      sss = tariff_info.services.select { |s| s.id == service.id }
      ss = service.to_hash.merge(sss.first.to_hash)
      ss.merge({service: ss})
    end.compact
    merged_hash[:services] = services
    merged_hash.merge!(merged_hash[:tariff])
    [merged_hash]
  end

  def find_tariff_link_by_user(id)
    tariff_link_tuple = volgaspot_tariff_links
      .base.by_user(id)
      .map_with(:volgaspot_tariff_links_mapper)
      .one!
    RecursiveOpenStruct.new tariff_link_tuple, recurse_over_arrays: true
  end

  def services
    ROM.env.relations[:services]
  end

  def volgaspot_tariff_links
    ROM.env.relations[:volgaspot_tariff_links]
  end
end
