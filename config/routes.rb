Hermes::Application.routes.draw do
  
  resources :inboxes


  devise_for :users

  resources :users

  root :to => 'home#index'

end
