Hermes::Application.routes.draw do
  
  devise_for :users

  resources :users

  root :to => 'home#index'

end
