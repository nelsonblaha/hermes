class Rule < ActiveRecord::Base
  attr_accessible :name, :user_id, :passing_children_needed_to_pass, :parent_rule_id, :passing_traits_needed_to_pass

  belongs_to :user
  has_many :presentations
  has_many :traits, as: :traited

  def child_rules_pass?(message)
    if self.passing_children_needed_to_pass.nil?
      return true
    else
      # This is a meta-rule controlling children rules. Check child rules to make sure enough are satisfied to pass self.
      # TODO make more efficient. Should exit when needed_to_pass < satisfied
      satisfied = 0
      all_passed = true
      at_least_one_fail = false
      # TODO enable rules to have multiple parents, so child rules can be reused by different parents
      Rule.where(parent_rule_id:self.id).each do |child_rule|
        if child_rule.pass?(message)
          satisfied += 1
        else
          all_passed = false
          at_least_one_fail = true
        end
      end
      
      #pass if enough are met. If needed_to_pass is 0, pass if all passed
      if ((satisfied >= self.passing_children_needed_to_pass ) && (self.passing_children_needed_to_pass > 0)) || (self.passing_children_needed_to_pass == 0 && all_passed == true)
        return true
      elsif at_least_one_fail == true
        return false
      else
        return nil
      end
    end
  end

  def traits_pass?(message)
    if needed_to_pass = self.passing_traits_needed_to_pass
      # This is a meta-rule controlling children rules. Check child rules to make sure enough are satisfied to pass self.
      # TODO make more efficient. Should exit when needed_to_pass < satisfied
      satisfied = 0
      all_passed = true
      at_least_one_fail = false
      # TODO enable rules to have multiple parents, so child rules can be reused by different parents
      self.traits.each do |rule_trait|
        pass = false
        Trait.where(traited_id:message.id,traited_type:'Message',name:rule_trait.name).each do |matching_message_trait|
          if rule_trait.pass?(matching_message_trait.value)
            pass = true
          end
        end

        if pass
          satisfied += 1
        else
          all_passed = false
          at_least_one_fail = true
        end
      end
      
      #pass if enough are met. If needed_to_pass is 0, pass if all passed
      if (satisfied > needed_to_pass) || (needed_to_pass == 0 && all_passed)
        true
      elsif at_least_one_fail == true
        false
      else
        nil
      end
    else
      true
    end
  end

  def pass?(message)
    if self.child_rules_pass?(message) && self.traits_pass?(message)
      return true
    else
      return false
    end
  end

	def process(message)
		if self.pass?(message)
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
