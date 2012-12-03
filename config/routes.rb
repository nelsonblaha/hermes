Hermes::Application.routes.draw do
  
  get "message_source/directory", as: 'message_source_directory'
  get "message_source/mine", as: 'my_message_sources'

  resources :presentations
  match "/presentations_index_for_rule" => "presentations#presentations_index_for_rule"

  resources :rules
  match "/rules_index_for_inbox" => "rules#rules_index_for_inbox"

  resources :traits


  resources :messages
  match '/resolve_message' => 'messages#resolve'

  resources :rss_feeds


  resources :inboxes


  devise_for :users

  resources :users

  root :to => 'home#index'

end
