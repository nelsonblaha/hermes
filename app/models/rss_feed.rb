require 'message_source'
class RssFeed < ActiveRecord::Base
  include MessageSource

  attr_accessible :name, :url, :user_id

  belongs_to :user
  has_many :messages, as: :message_source

  def new_messages
    new_messages = []
    Feedzirra::Feed.fetch_and_parse(self.url).entries.each do |entry|
      if entry.entry_id.nil? || (self.messages.where(unique_identifier:entry.entry_id).count == 0 && entry.entry_id)
        title = entry.title || "no title"
        traits = {'message_source_type'=>'RssFeed','message_source_id'=>self.id}
        entry.instance_variables.each {|var| traits[var.to_s.delete("@")] = entry.instance_variable_get(var).to_s }
        message = self.messages.create(traits_hash:traits.to_s)
        if entry.entry_id
          message.unique_identifier = entry.entry_id
          message.save
        end
        new_messages << message
      end
    end
    return new_messages
  end
end