class Message < ActiveRecord::Base
  attr_accessible :dismissed, :message_source_id, :message_source_type, :read, :traits_hash, :unique_identifier

  belongs_to :message_source, polymorphic: true
  has_many :traits, as: :traited
  has_many :presentations, dependent: :destroy
  has_many :inboxes, through: :presentations

  def subject
  	#TODO cleverly figure out message's subject by iterating through possible subject hash keys such as 'title','subject',etc  		
  	if eval(self.traits_hash)['title']
  		eval(self.traits_hash)['title']
  	else 
  		self.id.to_s
  	end
  end
end
