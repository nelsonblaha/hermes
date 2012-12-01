class RssFeed < ActiveRecord::Base
  attr_accessible :name, :url, :user_id

  has_one :user
  has_many :messages, as: :message_source

  def new_messages
    new_messages = []
    Feedzirra::Feed.fetch_and_parse(self.url).entries.each do |entry|
      title = entry.title || "no title"
      new_messages << self.messages.create(summary:title)
    end
    return new_messages
  end
end