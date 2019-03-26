class TariffRepository < ROM::Repository::Root
  include Import[
    'relations.available_tariffs',
    'relations.services',
    'relations.volgaspot_tariffs',
    'relations.volgaspot_tariff_links'
  ]

  root :tariffs

  auto_struct false
  struct_namespace Rapi::Entities

  def tariffs_by_user(id)
    tariff_link = find_tariff_link_by_user id
    return [] unless tariff_link

    tariff_data = get_tariff_data tariff_link.tariff.id, tariff_link.services.map(&:id)
    combined_data = merge_tariff_data tariff_link, tariff_data.first
    combined_data.map { |s|  Volgaspot::TariffLink.new(s) }
  end

  def available_tariffs_for_user(id)
    tariff_ids = get_available_tariffs_for_user(id).map { |el| el[:id] }
    return [] if tariff_ids.empty?

    get_tariff_data tariff_ids
  end

  def unlink_tariff_for_user(id)
    response = volgaspot_tariff_links.command(:delete).call id
    response[:success] and response[:data]
  end

  def link_tariff_for_user(id, tariff_id)
    response = volgaspot_tariff_links.command(:create).call id, tariff_id
    response[:success]
  end

  private

  def get_tariff_data(tariff_ids, service_ids = nil)
    volgaspot_data_thread = Thread.new { get_volgaspot_tariff_data(tariff_ids).to_a }
    utm_tariff_data = get_utm_tariff_data(tariff_ids, service_ids).to_a
    volgaspot_tariff_data = volgaspot_data_thread.join.value
    utm_tariff_data.each do |utm_tariff|
      volgaspot_tariff = volgaspot_tariff_data.find { |volgaspot_tariff| volgaspot_tariff[:id] == utm_tariff[:id] }
      utm_tariff.merge! volgaspot_tariff
    end
    TariffsMapper.build.call utm_tariff_data
  end

  def get_available_tariffs_for_user(id)
    available_tariffs.base.by_user(id).to_a
  end

  def get_utm_tariff_data(tariff_ids, service_ids = nil)
    relation = tariffs.by_id(tariff_ids).combine(:services).node(:services, &:main)
    relation.node(:services) { |services| services.by_id(service_ids) } if service_ids
    relation
  end

  def get_volgaspot_tariff_data(tariff_ids)
    volgaspot_tariffs.base.by_ids tariff_ids
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

  # TODO: find a way for mapper to skip empty values and call it here
  def find_tariff_link_by_user(id)
    raw_tuple = volgaspot_tariff_links
      .base.by_user(id)
      .one
    return false if raw_tuple[:active_tariff_link].empty?

    tuple = Volgaspot::TariffLinksMapper.build.call([raw_tuple]).first
    RecursiveOpenStruct.new tuple, recurse_over_arrays: true
  end
end
