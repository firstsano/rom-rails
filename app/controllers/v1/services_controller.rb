module V1
  class ServicesController < BaseController
    def index
      services = repo.services_by_user current_user_session.id
      respond_with Volgaspot::ServiceBlueprint.render(services)
    end

    private

    def repo
      ServiceRepository.new(ROM.env)
    end
  end
end
