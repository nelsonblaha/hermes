require 'message_source'
class RssFeed < ActiveRecord::Base
  include MessageSource

  attr_accessible :name, :url, :user_id

  belongs_to :user
  has_many :messages, as: :message_source

  after_create :default_present_to_news_inbox_template

  validates :user, presence: true

  def default_present_to_news_inbox_template
    news = Inbox.where(template:'news',user_id:self.user.id).first_or_create
    news.name ||= "News"
    news.save
    rule = Rule.create(name:'Send all messages from '+self.name+' to '+news.name,user_id:self.user_id)
    trait = rule.traits.create(name:'message_source_id',value:self.id.to_s)
    trait = rule.traits.create(name:'message_source_type',value:'rss_feed')
    presentation = rule.presentations.create(inbox_id:news.id)
  end

  def new_messages
    new_messages = []
    Feedzirra::Feed.fetch_and_parse(self.url).entries.each do |entry|
      if entry.entry_id.nil? || (entry.entry_id && self.messages.where(unique_identifier:entry.entry_id).count == 0)
        message = self.messages.create(unique_identifier:entry.entry_id)
        
        title = entry.title || "no title"
        message.traits.create(name:'title',value:title)

        entry.instance_variables.each do |var| 
          message.traits.create(name:var.to_s.delete("@"),value:entry.instance_variable_get(var).to_s)
        end

        message.traits.create(name:'message_source_type',value:'rss_feed')
        message.traits.create(name:'message_source_id',value:self.id)

        new_messages << message

        message.distribute!
      end
    end
    return new_messages
  end

  def common_name
    "RSS Feed"
  end
end