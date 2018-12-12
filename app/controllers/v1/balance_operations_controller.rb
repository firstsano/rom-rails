module V1
  class BalanceOperationsController < BaseController
    def index
      balance_operations = repo.balance_operations_by_user current_user_session.account
      respond_with BalanceItemBlueprint.render(balance_operations)
    end

    private

    def repo
      BalanceOperationRepository.new(ROM.env)
    end
  end
end