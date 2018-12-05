module V1
  class TariffsController < BaseController
    def index
      tariffs = repo.by_user current_user_session.id
      respond_with TariffBlueprint.render(tariffs)
    end

    private

    def repo
      Volgaspot::TariffLinkRepository.new(ROM.env)
    end
  end
end
