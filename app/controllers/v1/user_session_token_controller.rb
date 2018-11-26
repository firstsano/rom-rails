module V1
  class UserSessionTokenController < ::Knock::AuthTokenController
    skip_before_action :verify_authenticity_token
  end
end
