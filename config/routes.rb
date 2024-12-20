Rails.application.routes.draw do
  devise_for :accounts

  resources :transactions
  resources :withdrawals
  resources :deposits

  get "home/index"
  get "statement/statement"

  root "home#index"
end
