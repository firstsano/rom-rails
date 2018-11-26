class Login < ROM::Commands::Update[:http]
  relation :user_sessions
  register_as :login
  result :one

  def execute(login, password)
    relation
        .dataset
        .with_base_path('/customer-sessions/login')
        .with_options(request_method: :put, params: {
            login: login,
            password: password
        })
        .response
  end
end
