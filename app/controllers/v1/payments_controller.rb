module V1
  class PaymentsController < BaseController
    def show
      repo.payment_by_id params[:id]
    end

    def create
      is_created = repo.create_payment_for_user current_user_session.id
      return head :unprocessable_entity unless is_created

      head :created
    end

    private

    def repo
      PaymentRepository.new(ROM.env)
    end
  end
end
