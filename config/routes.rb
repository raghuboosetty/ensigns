Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: "admins/sessions" }
  resources :items do
    get :upload, on: :collection
  end
  resources :customers do 
    get :stats, on: :member
  end
  get 'dashboard/index'
  
  root to: 'dashboard#index'
end