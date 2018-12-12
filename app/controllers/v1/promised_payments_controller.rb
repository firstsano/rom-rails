module V1
  class PromisedPaymentsController < BaseController
    def index
      status = repo.status_by_user current_user_session.id
      respond_with Volgaspot::PromisedPaymentBlueprint.render(status)
    end

    private

    def repo
      PromisedPaymentRepository.new(ROM.env)
    end
  end
end