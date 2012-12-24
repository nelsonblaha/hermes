class Trait < ActiveRecord::Base
  attr_accessible :name, :traited_id, :traited_type, :value, :mode

  belongs_to :message, polymorphic: true
  belongs_to :rule, polymorphic: true

  def modes
  	{1=>'exact match',2=>"contains (case-agnostic)",3=>"contains (case-sensitive)"}
  end

  def pass?(value)
  	case self.mode
  	when 1
  		if value == self.value
  			return true
  		end
  	#TODO complete other modes here
  	else
  		return false
  	end
  	return false
  end
end
