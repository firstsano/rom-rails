module V1
  class TariffsController < BaseController
    def index
      tariffs = repo.tariffs_by_user current_user_session.id
      respond_with Volgaspot::TariffBlueprint.render(tariffs)
    end

    def available
      tariffs = repo.available_tariffs_for_user current_user_session.id
      respond_with TariffBlueprint.render(tariffs)
    end

    def destroy
      is_unlinked = repo.unlink_tariff_for_user current_user_session.id
      return head :unprocessable_entity unless is_unlinked

      head :no_content
    end

    private

    def repo
      TariffRepository.new(ROM.env)
    end
  end
end
