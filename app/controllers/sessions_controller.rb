class SessionsController < ApplicationController
  
    def new
      end

    def create
    auth_hash = request.env['omniauth.auth']

      if session[:user_id]
        # User is already in a session
        User.find(session[:user_id]).add_provider(auth_hash)
     
        redirect_to root_url
      else
        # Log him in or sign him up
        auth = Authorization.find_or_create(auth_hash)
     
        # Create the session
        session[:user_id] = auth.user.id
     
        redirect_to root_url
      end
    end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
    end

    def destroy
    session[:user_id] = nil
    redirect_to root_url
    end
end
