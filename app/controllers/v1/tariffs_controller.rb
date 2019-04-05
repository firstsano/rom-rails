module V1
  class TariffsController < BaseController
    def index
      tariffs = repo.tariffs_by_user current_user_session.id
      respond_with Volgaspot::TariffLinkBlueprint.render(Array(tariffs))
    end

    def available
      tariffs = repo.available_tariffs_for_user current_user_session.id
      respond_with TariffBlueprint.render(tariffs)
    end

    def create
      tariff_id = params.dig :tariff_link, :tariff_id
      is_linked = repo.link_tariff_for_user current_user_session.id, tariff_id
      return head :unprocessable_entity unless is_linked

      head :created
    end

    def destroy
      is_unlinked = repo.unlink_tariff_for_user current_user_session.id
      return head :unprocessable_entity unless is_unlinked

      head :ok
    end

    private

    def schemas
      {
        create: Dry::Validation.Schema do
                  required(:tariff_link).schema do
                    required(:tariff_id).filled.int?
                  end
                end
      }
    end

    def repo
      TariffLinkRepository.new(ROM.env)
    end
  end
end
