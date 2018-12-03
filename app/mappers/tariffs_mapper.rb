class TariffsMapper < ROM::Mapper
  relation :tariffs

  register_as :tariffs_mapper

  reject_keys true

  attribute :id
  attribute :name
  attribute(:description, from: :comments) { |desc| sanitize desc }
  attribute :services

  def sanitize(description)
    without_html = Sanitize.fragment description
    without_html.strip.gsub(/(\s)\s+/, '\1')
  end
end
