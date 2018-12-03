module V1
  class TariffsController < BaseController
    def index
      tariffs = repo.find_by_user current_user_session.id
      respond_with tariffs
    end

    private

    def repo
      Volgaspot::TariffLinkRepository.new(ROM.env)
    end
  end
end
