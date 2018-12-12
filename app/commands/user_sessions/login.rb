module UserSessions
  class Login < ROM::Commands::Update[:http]
    relation :user_sessions
    register_as :login
    result :one

    def execute(login, password)
      login_params = { login: login, password: password }
      relation
          .dataset
          .with_base_path('/customer-sessions/login')
          .with_options(request_method: :put, params: login_params)
          .response
    end
  end
end
