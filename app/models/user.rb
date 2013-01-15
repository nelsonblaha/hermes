class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :inboxes
  has_many :rss_feeds
  has_many :rules

  after_create :authorize

  def authorize
    if AUTHORIZE_NEW_USERS
      self.authorized = true
      self.save
    end
  end

  def best_name
    name = self.email.scan(/(.*?)@/).first.first.downcase.titleize
    name.gsub!('.',' ')
    name
  end

end
