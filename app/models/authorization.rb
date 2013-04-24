require 'message_source'
class Authorization < ActiveRecord::Base
  include MessageSource
  attr_accessible :link, :name, :provider, :secret, :token, :uid, :user_id, :refresh_token, :last_item_id

  validates :provider, :uid, presence: :true

  belongs_to :user
  
  has_many :messages, as: :message_source
  has_many :traits, as: :traited

  after_create :default_present_to_news_inbox_template, :default_traits_creation

  def self.find_or_create(auth_hash)
    auth = Authorization.where(provider:auth_hash["provider"],uid:auth_hash["uid"]).first
    if auth.nil?
        user = User.where(email:auth_hash["info"]["email"]).first_or_create
        auth = Authorization.create(user_id:user.id,provider:auth_hash["provider"],uid:auth_hash["uid"],token:auth_hash["credentials"]['token'])
        if auth_hash['credentials']['refresh_token']
          auth.refresh_token = auth_hash['credentials']['refresh_token']
        end
        if auth_hash['credentials']['secret']
          auth.secret = auth_hash['credentials']['secret']
        end
        if auth_hash['info']['name']
          auth.name = "@"+auth_hash['info']['nickname']
        end
        auth.save
      end
      auth
  end

  def default_present_to_news_inbox_template
    news = Inbox.where(template:'news',user_id:self.user.id).first_or_create
    news.name ||= "News"
    news.save
    rule = Rule.create(name:'Send all messages from Twitter to inbox: '+news.name,user_id:self.user_id,passing_traits_needed_to_pass:0,passing_children_needed_to_pass:0)
    trait = rule.traits.create(name:'message_source_id',value:self.id.to_s)
    trait = rule.traits.create(name:'message_source_type',value:'Authorization')
    presentation = rule.presentations.create(inbox_id:news.id)
  end

  def default_traits_creation
    # keeping all the traits is too expensive... specific traits to be generated for each message are authorized here by trait objects attached to the rss_feed.
    trait = self.traits.create(name:"screen_name")
    trait = self.traits.create(name:"title")
    trait = self.traits.create(name:"subject")
    trait = self.traits.create(name:"sender")
    # very bad. these are included just for silly bad tests
    trait = self.traits.create(name:"color")
    trait = self.traits.create(name:"age")
  end

  def new_messages
    new_messages = []
    self.tweets.each do |tweet|
      if tweet.id && self.messages.where(unique_identifier:tweet.id.to_s).count == 0
        message = self.messages.create(unique_identifier:tweet.id.to_s)

        title = tweet.text || "no title"
        message.traits.create(name:'title',value:title)

        # get twitter-specific stuff buried under 'user' var and make traits from it prefixed with 'user_'
        tweet.user.attrs.each do |var|
          if self.traits.where(name:var.to_s.delete("@")).count > 0
            message.traits.create(name:"user_"+var[0].to_s.delete(":"),value:var[1].to_s)
          end
        end

        tweet.attrs.each do |var| 
          if self.traits.where(name:var.to_s.delete("@")).count > 0
            message.traits.create(name:var[0].to_s.delete(":"),value:var[1].to_s)
          end
        end

        message.traits.create(name:'message_source_type',value:'Authorization')
        message.traits.create(name:'message_source_id',value:self.id)

        new_messages << message

        message.distribute!
      end
    end
    return new_messages
  end

  # twitter methods
    def tweets
        Twitter.configure do |config|
          config.consumer_key = TWITTER_KEY
          config.consumer_secret = TWITTER_SECRET
          config.oauth_token = self.token
          config.oauth_token_secret = self.secret
        end

        twitter_client = Twitter::Client.new
        if self.last_item_id
          tweets = twitter_client.home_timeline(options = {:count => 200, :since_id => self.last_item_id, :include_rts => true, :contributor_details => true})
        else
          tweets = twitter_client.home_timeline(options = {:count => 5, :include_rts => true, :contributor_details => true})
          self.last_item_id = tweets.first.id
          self.save
        end
        tweets
    end
end
