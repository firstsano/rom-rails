module V1
  class PromisedPaymentsController < BaseController
    def index
      status = repo.status_by_user current_user_session.id
      respond_with Volgaspot::PromisedPaymentBlueprint.render(status)
    end

    def create
      created = repo.create_promised_payment_for_user current_user_session.id
      return head :unprocessable_entity unless created

      head :created
    end

    private

    def repo
      PromisedPaymentRepository.new(ROM.env)
    end
  end
end