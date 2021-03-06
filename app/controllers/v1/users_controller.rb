module V1
  class UsersController < BaseController
    def index
      user = repo.user_by_id current_user_session.id
      respond_with UserBlueprint.render(user)
    end

    private

    def repo
      UserRepository.new(ROM.env)
    end
  end
end
