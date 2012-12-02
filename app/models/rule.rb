class Rule < ActiveRecord::Base
  attr_accessible :limit, :meta_or_mode, :meta_rule_id, :mode, :name, :rule_owner_id, :rule_owner_type, :logic

  belongs_to :user, polymorphic:true
  has_many :presentations

 	def process(message)
 		#create logic filter
	 		filter = self.logic
	 		message.traits_hash.each do |trait|
	 			filter.gsub!(trait[0].to_s,"'"+trait[1].to_s+"'")
	 		end
	 	#create context filter
	 	
	 		if eval(filter.to_s)
	 			self.presentations.each do |presentation|
	 				Presentation.create(inbox_id:presentation.inbox_id,message_id:message.id)
	 			end
	 			true
	 		end
 	end
end
