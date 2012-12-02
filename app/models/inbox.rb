class Inbox < ActiveRecord::Base
  attr_accessible :message_expiration_seconds, :messages_expire, :name, :user_id

  belongs_to :user
  has_many :messages, through: :presentation

  def summary
  	message = self.name + ": " + self.active_presentations.count.to_s
  	message << " (" + self.unread_active_presentations.count.to_s + " unread)" if unread_active_presentations.count > 0
  	message
  end

  def active_presentations
  	#TODO
  	[]
  end

  def unread_active_presentations
  	#TODO
  	[]
  end
end
