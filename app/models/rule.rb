class Rule < ActiveRecord::Base
  attr_accessible :limit, :meta_or_mode, :meta_rule_id, :mode, :name, :rule_owner_id, :rule_owner_type, :logic

  belongs_to :user, polymorphic:true

 	def process(message)
 		post_sub_logic = self.logic
 		message.traits_hash.to_a.each do |trait|
 			post_sub_logic.gsub!(trait[0].to_s,"'"+trait[1].to_s+"'")
 		end
 		if eval(post_sub_logic.to_s)
 			#TODO perform inboxing action
 			true
 		end
 	end

end
