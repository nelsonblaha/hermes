class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :check_admin, :check_authorized

  #security methods
      def check_admin
        if current_user && current_user.admin
          return true
        else
          redirect_to root_url, notice: "access denied"
        end
      end

      def check_authorized
        if current_user && current_user.authorized
          return true
        else
          redirect_to root_url, notice: "access denied"
        end
      end
      
  private 

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
