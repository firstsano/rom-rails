class ServicesMapper < ROM::Mapper
  relation :services

  register_as :services_mapper

  model Service

  attribute :id
  attribute :name, from: :service_name
  attribute(:description, from: :comment) { |desc| sanitize desc }
  attribute :cost

  def sanitize(description)
    Sanitize.fragment(description)
            .strip
            .gsub(/(\s)\s+/, '\1')
  end
end
