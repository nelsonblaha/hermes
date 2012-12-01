Hermes::Application.routes.draw do
  
  resources :messages


  resources :rss_feeds


  resources :inboxes


  devise_for :users

  resources :users

  root :to => 'home#index'

end
