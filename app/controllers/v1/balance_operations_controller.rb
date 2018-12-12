module V1
  class BalanceOperationsController < BaseController
    before_action :get_pagination_params, only: :index

    def index
      account = current_user_session.account
      balance_operations = repo.balance_operations_by_user account, page: @page, per_page: @per_page
      respond_with BalanceItemBlueprint.render(balance_operations)
    end

    private

    def repo
      BalanceOperationRepository.new(ROM.env)
    end
  end
end