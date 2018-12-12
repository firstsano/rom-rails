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

    resources :tariffs, only: %i[index create] do
      get :available, on: :collection
      delete :index, action: :destroy, on: :collection
    end

    resources :services, only: %i[index]

    get '/balance-history' => 'balance_operations#index'

    resources :promised_payments, only: %i[index create], path: '/promised-payments' do
      get :status, action: :index, on: :collection
    end
  end
end
