class Message < ActiveRecord::Base
  attr_accessible :resolved, :message_source_id, :message_source_type, :read, :traits_hash, :unique_identifier

  belongs_to :message_source, polymorphic: true
  has_many :traits, as: :traited
  has_many :presentations, dependent: :destroy
  has_many :inboxes, through: :presentations

  def message_subject
  	#TODO cleverly figure out message's subject by iterating through possible subject hash keys such as 'title','subject',etc  		
  	if title = message_hash['title']
  		title
  	else 
  		"unknown subject"
  	end
  end
  
  def message_hash
    eval(self.traits_hash)
  end

  def source
    if message_source && message_source.name
      source_name = message_source.name
    else
      source_name = ""
    end
    [source_name,message_hash['message_source_type']]
  end

  def traits_for_presentation
    traits = []
    #traits being sucked into alternate metadata presentations
    traits_to_remove = ['message_source_type','message_source_id','author']
    message_hash.each do |trait|
      remove = false
      traits_to_remove.each do |removeit|
        remove = true if trait[0] == removeit
      end
      traits << trait unless remove
    end
    traits
  end

  def sender
    message_hash['author'] || "unknown sender"
  end
end
