class Rule < ActiveRecord::Base
  attr_accessible :limit, :meta_or_mode, :meta_rule_id, :mode, :name, :user_id, :logic

  belongs_to :user
  has_many :presentations
  has_many :traits, as: :traited

  	def process(message)
  		if self.any_trait_matches(message)
  			self.apply_presentations_to(message)
  		end
  	end

  	def apply_presentations_to(message)
  		self.presentations.each do |presentation|
 			Presentation.create(inbox_id:presentation.inbox_id,message_id:message.id)
 		end
  	end

 	def any_trait_matches(message)
 		#TODO could be much more efficient
 		pass = false

 		self.traits.each do |rule_trait|
 			message.traits.each do |message_trait|
 				if rule_trait.name == message_trait.name && rule_trait.value == message_trait.value
 					pass = true
 				end
 		end

 		return pass
 	end

 	def super_string
 		case self.super_mode
 			when nil
 				'not a super_rule'
 			when 0
 				'all meta_rule'
 			when 2
 				'any two rule'
 			when 3
 				'any three rule'
 			else
 				'any n rule'
 			end
 		end
 	end

end
