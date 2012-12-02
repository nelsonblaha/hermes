require 'test_helper'

class RuleTest < ActiveSupport::TestCase
	#TODO false positive - in message_source self.user.rules is returning []
	test 'equality rule logic' do
		rule = create(:rule,logic:"title == 'Ruby'")
		message = create(:message,traits_hash:{'title'=>'Ruby'})
  		assert rule.process(message), "rule.process did not return true when processing a message matching rule's logic"
	end
end 
