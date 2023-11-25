Rails.application.routes.draw do
 get'/users', to: 'users#index'
 get'/users/new', to: 'users#new'
 get'/logs/index', to: 'logs#index'
 get'/users/consultar', to: 'users#consultar'
 get'/users/edit', to: 'users#edit'
 get'/logs/consultar', to: 'logs#consultar'
 get'users/show', to: 'users#show'

 

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#index"
  resources :users, except: :show
  get "users/:docType/:docNum", to: "users#show", as: :show
  resources :logs, only: :create
end
