Hermes::Application.routes.draw do
  
  resources :presentations


  resources :rules


  resources :traits


  resources :messages


  resources :rss_feeds


  resources :inboxes


  devise_for :users

  resources :users

  root :to => 'home#index'

end
