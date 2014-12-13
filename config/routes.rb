Rails.application.routes.draw do
  devise_for :admins
  resources :items
  resources :customers
  
  root to: "items#index"
end