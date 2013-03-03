MembersCurrency::Application.routes.draw do
  root to: 'members#index'
  resources :members
  resources :currencies
  resources :log_for_currencies
  resources :money_tickets

  get '/login/:member_id', to: 'members#login', as: :login
  get '/logout', to: 'members#logout', as: :logout
  get '/member/give/:from_id/:to_id/:currency_id', to: 'members#confirm_to_give', as: :confirm_give
  post '/member/give/:from_id/:to_id/:currency_id', to: 'members#give', as: :give
  get '/currency/publish/:currency_id', to: 'currencies#publish', as: :currency_publish
  post '/currency/publish/:currency_id', to: 'currencies#add_amount', as: :post_currency_publish
  get '/money_ticket/exchange', to: 'money_tickets#exchange', as: :exchange_point
  post '/money_ticket/exchange', to: 'money_tickets#confirm_exchange', as: :confirm_exchange
  post '/money_ticket/use', to: 'money_tickets#use', as: :use_point
end

