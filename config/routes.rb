Rails.application.routes.draw do
 get'/users', to: 'users#index'
 get'/users/new', to: 'users#new'
 get'/users/log', to: 'users#log'
 get'/users/consultar', to: 'users#consultar'

 


end
