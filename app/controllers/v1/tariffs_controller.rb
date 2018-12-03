module V1
  class TariffsController < BaseController
    def index
      user_tariff = repo.find_by_user current_user_session.id
      respond_with user_tariff
    end

    private

    def repo
      Volgaspot::TariffLinkRepository.new(ROM.env)
    end
  end
end
