class TariffsMapper < ROM::Mapper
  relation :tariffs

  register_as :tariffs_mapper

  model Tariff
  attribute :id
  attribute :name
  attribute(:description, from: :comments) { |desc| sanitize desc }

  embedded :services, mapper: ServicesMapper, type: :array

  def sanitize(description)
    Sanitize.fragment(description)
            .strip
            .gsub(/(\s)\s+/, '\1')
  end
end
