module V1
  class PaymentsController < BaseController
    def show
      repo.payment_by_id params[:id]
    end

    def create
      payment = repo.create_payment_for_user current_user_session.id, payment_params
      render json: payment, status: :created
    end

    private

    def repo
      PaymentRepository.new(ROM.env)
    end

    def payment_params
      params.require(:payment).permit!.to_h
    end

    def schemas
      {
        create: Dry::Validation.Schema do
                  required(:payment).schema do
                    required(:idempotence_key).filled.str?
                    required(:payment_token).filled.str?
                    required(:amount).schema do
                      required(:value).filled
                      required(:currency).filled.str?
                    end
                  end
                end
      }
    end
  end
end
