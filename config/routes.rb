Hermes::Application.routes.draw do
  
  resources :presentations
  match "/presentations_index_for_rule" => "presentations#presentations_index_for_rule"

  resources :rules
  match "/rules_index_for_inbox" => "rules#rules_index_for_inbox"

  resources :traits


  resources :messages


  resources :rss_feeds


  resources :inboxes


  devise_for :users

  resources :users

  root :to => 'home#index'

end
