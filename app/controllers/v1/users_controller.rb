module V1
  class UsersController < BaseController
    def index
      user_info = repo.find current_user_session.id
      respond_with user_info
    end

    private

    def repo
      Volgaspot::UserRepository.new(ROM.env)
    end
  end
end
