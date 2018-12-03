Rails.application.routes.draw do
  api_version module: 'v1',
              header: {
                name: 'Accept',
                value: "application/vnd.#{ENV['company']}.com; version=1"
              },
              default: true,
              defaults: { format: :json } do

    post '/users/sign-in' => 'user_session_token#create'

    get '/me' => 'users#index'

    resources :tariffs, only: %i[index create update destroy]
  end
end
