require 'test_helper'

class MessageTest < ActiveSupport::TestCase

	test 'trait_value: returns created_at of message when asked for value of trait: hermes_received_time' do
		message = create(:message)
		assert_equal message.value('hermes_received_time'), message.created_at.to_s
	end

	test 'trait_value: returns trait value when asked for' do
		message = create(:green_message)
		assert_equal 'green', message.value('color')
	end

	test 'trait_value: returns nil when asking for non-existent trait' do
		message = create(:green_message)
		assert_nil message.value('age')
	end

	test 'distribute' do
		#TODO
	end

	

end
