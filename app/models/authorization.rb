class Authorization < ActiveRecord::Base
  attr_accessible :link, :name, :provider, :secret, :token, :uid, :user_id

  belongs_to :user
end
