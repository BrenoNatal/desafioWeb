Rails.application.routes.draw do
  devise_for :accounts

  resources :transactions
  resources :withdrawals
  resources :deposits
  resources :services, only: [ :create ]


  get "home/index"
  get "statement/statement"

  root "home#index"
end
