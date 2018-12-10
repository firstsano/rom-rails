module V1
  class ServicesController < BaseController
    def index
      services = repo.services_by_user current_user_session.id
      services_by_type = Volgaspot::ServiceBlueprint.render_as_hash(services)
                                                    .group_by { |el| el[:type] }
      respond_with services_by_type
    end

    private

    def repo
      ServiceRepository.new(ROM.env)
    end
  end
end
