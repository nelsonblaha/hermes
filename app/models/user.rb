class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :inboxes
  has_many :rss_feeds, :dependent => :destroy
  has_many :authorizations, :dependent => :destroy
  has_many :rules

  after_create :authorize

  def add_provider(auth_hash)
      # Check if the provider already exists, so we don't add it twice
      unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
          auth = self.authorizations.create(
            provider:auth_hash["provider"],
            uid:auth_hash["uid"],
            token:auth_hash['credentials']['token'],
            refresh_token:auth_hash['credentials']['refresh_token'],
            secret:auth_hash['credentials']['secret']
          )
      end
  end

  def authorize
    if AUTHORIZE_NEW_USERS
      self.authorized = true
      self.save
    end
  end

  def best_name
    if self.email
      name = self.email.scan(/(.*?)@/).first.first.downcase.titleize
      return name.gsub('.',' ')
    else
      return "New User"
    end
  end

  def has_auth(provider)
    if self.authorizations.where(provider:"twitter").count > 0
      true
    else
      false
    end
  end

end
