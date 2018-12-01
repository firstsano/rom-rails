class TariffsMapper < ROM::Mapper
  relation :tariffs

  register_as :tariffs_mapper

  reject_keys true

  attribute :id
  attribute :name
  attribute(:description, from: :comments) { |d| d.gsub /[\\\n]/, '' }
end
