MembersCurrency::Application.routes.draw do
  root to: 'members#index'
  resources :members
  resources :currencies
  resources :log_for_currencies

  get '/login/:member_id', to: 'members#login', as: :login
  get '/logout', to: 'members#logout', as: :logout
  get '/member/give/:from_id/:to_id/:currency_id', to: 'members#confirm_to_give', as: :confirm_give
  post '/member/give/:from_id/:to_id/:currency_id', to: 'members#give', as: :give
end
