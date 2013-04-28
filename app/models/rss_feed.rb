require 'message_source'
class RssFeed < ActiveRecord::Base
  include MessageSource

  attr_accessible :name, :url, :user_id

  belongs_to :user
  has_many :messages, as: :message_source
  has_many :traits, as: :traited

  after_create :default_present_to_news_inbox_template, :default_traits_creation

  validates :user, presence: true

  def default_present_to_news_inbox_template
    news = Inbox.where(template:'news',user_id:self.user.id).first_or_create
    news.name ||= "News"
    news.save
    rule = Rule.create(name:'Send all messages from source: '+self.name+' (RSS Feed) to inbox: '+news.name,user_id:self.user_id,passing_traits_needed_to_pass:0,passing_children_needed_to_pass:0)
    trait = rule.traits.create(name:'message_source_id',value:self.id.to_s)
    trait = rule.traits.create(name:'message_source_type',value:'rss_feed')
    presentation = rule.presentations.create(inbox_id:news.id)
  end

  def default_traits_creation
    # keeping all the traits is too expensive... specific traits to be generated for each message are authorized here by trait objects attached to the rss_feed.
    trait = self.traits.create(name:"title")
    trait = self.traits.create(name:"subject")
    trait = self.traits.create(name:"sender")
    trait = self.traits.create(name:"url")
    # very bad. these are included just for silly bad tests
      trait = self.traits.create(name:"color")
      trait = self.traits.create(name:"age")

  end

  def new_messages
    new_messages = []
    Feedzirra::Feed.fetch_and_parse(self.url).entries.each do |entry|
      #TODO better unique identifier, this one sucks
      if entry.published && self.messages.where(message_source_id:self.id,unique_identifier:entry.published).count == 0
        message = self.messages.create(unique_identifier:entry.published,message_source_id:self.id)

        title = entry.title || "no title"
        message.traits.create(name:'title',value:title)

        entry.instance_variables.each do |var| 
          if self.traits.where(name:var.to_s.delete("@")).count > 0
            message.traits.create(name:var.to_s.delete("@"),value:entry.instance_variable_get(var).to_s)
          end
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