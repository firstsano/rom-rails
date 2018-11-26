module V1
  class UsersController < BaseController
    respond_to :json

    def index
      user_info = repo.by_id current_user_session.id
      respond_with user_info
    end

    private

    def repo
      UserRepository.new(ROM.env)
    end
  end
end