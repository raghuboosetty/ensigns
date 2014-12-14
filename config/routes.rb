Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: "admins/sessions" }
  resources :items
  resources :customers
  get 'dashboard/index'
  
  root to: 'dashboard#index'
end