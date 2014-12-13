Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: "admins/sessions" }
  resources :items
  resources :customers
  
  root to: "items#index"
end