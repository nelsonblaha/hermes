class Inbox < ActiveRecord::Base
  attr_accessible :message_expiration_seconds, :messages_expire, :name, :user_id, :template

  belongs_to :user
  has_many :presentations
  has_many :messages, through: :presentations

  def summary
  	message = self.name
  	message << " (" + self.unread_active_presentations.count.to_s + " unread)" if unread_active_presentations.count > 0
  	message
  end

  def active_presentations
  	self.presentations
  end

  def unread_active_presentations
  	unread_active = []
    self.presentations.each do |p|
      if p.message && !p.rule && !p.message.read && !p.message.resolved
        unread_active << p
      end
    end
    unread_active
  end

  def check
    new_messages_qty = 0
    self.user.rss_feeds.each do |source|
      new_messages_qty += source.new_messages.count
    end
    self.user.authorizations.each do |authorization|
      new_messages_qty += authorization.new_messages.count
    end
    return new_messages_qty
  end
end
