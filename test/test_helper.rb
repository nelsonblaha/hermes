ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  class Test::Unit::TestCase
  	include FactoryGirl::Syntax::Methods
  end

  def setup
  	@default = create(:user)

    #stub current_user with the default user
    if @controller
    	@controller.stubs(:current_user).returns(@default)
    end
  end
end