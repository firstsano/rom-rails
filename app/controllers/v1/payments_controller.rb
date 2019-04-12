module V1
  class PaymentsController < BaseController
    def show
      payment = repo.payment_by_id params[:id]
      render json: PaymentBlueprint.render(payment)
    end

    def create
      account = current_user_session.vist_account
      token, amount = payment_params[:token], payment_params[:amount]
      payment = repo.create_payment_for_account account, token, amount
      render json: payment, status: :created
    end

    private

    def repo
      PaymentRepository.new(ROM.env)
    end

    def payment_params
      params.require(:payment).permit :token, :amount
    end

    def schemas
      {
        create: Dry::Validation.Schema do
                  required(:payment).schema do
                    required(:token).filled.str?
                    required(:amount).filled.float?
                  end
                end
      }
    end
  end
end
