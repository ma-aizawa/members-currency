MembersCurrency::Application.routes.draw do
  root to: 'members#index'
  resources :members
  resources :currencies
  resources :log_for_currencies

  get '/login/:member_id', to: 'members#login', as: :login
  get '/logout', to: 'members#logout', as: :logout
end
