class RssFeed < ActiveRecord::Base
  attr_accessible :name, :url, :user_id

  has_one :user

  def new_messages
  	require 'active_support'

  	new_messages = []

  	hash = Hash.from_xml(HTTParty.get(self.url))
  	hash['rss']['channel']['item'].each do |item|
  		new_message = Message.create
  		new_message.xml_traits(item)
  		new_messages << new_message
  	end
  	messages
  end
end