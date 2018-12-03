class TariffsMapper < ROM::Mapper
  relation :tariffs

  register_as :tariffs_mapper

  reject_keys true

  attribute :id
  attribute :name
  attribute(:description, from: :comments) { |desc| sanitize desc }

  embedded :services, type: :array do
    attribute :id
    attribute :name, from: :service_name
    attribute(:description, from: :comment) { |desc| Sanitize.fragment desc }

    unwrap :parent do
      attribute :type, from: :service_name
    end
  end

  def sanitize(description)
    without_html = Sanitize.fragment description
    without_html.strip.gsub(/(\s)\s+/, '\1')
  end
end
