Hermes::Application.routes.draw do
  
  match "/clear_resolved" => 'messages#clear_resolved'

  # message sources
    get "message_source/directory", as: 'message_source_directory'
    get "message_source/mine", as: 'my_message_sources'
    # post "message_sources/:message_id/check"

  resources :presentations
  match "/presentations_index_for_rule" => "presentations#index_for_rule"

  resources :rules
  match "/rules_index_for_inbox" => "rules#index_for_inbox"

  resources :traits


  resources :messages
  match '/resolve_message' => 'messages#resolve'

  resources :rss_feeds


  resources :inboxes
  match '/inbox_resolve_all_messages' => 'inboxes#resolve_all_messages'
  match '/inbox_check_for_messages' => 'inboxes#check_for_messages'
  match '/pull' => 'inboxes#pull'

  #omniauth
    get   '/login', :to => 'sessions#new', :as => :login
    match '/auth/:provider/callback', :to => 'sessions#create'
    match '/auth/failure', :to => 'sessions#failure'
    get '/logout', :to => 'sessions#destroy', :as => :logout
    
  resources :users

  root :to => 'home#index'

end
