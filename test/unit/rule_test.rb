require 'test_helper'

class RuleTest < ActiveSupport::TestCase
	test 'any_trait_match: simple trait comparison rule' do
		rss = create(:rss_feed)
		rule = create(:rule)
		rule_trait = rule.traits.create(name:"message_source",value:rss.id.to_s)
		message = create(:message)
		message_trait = message.traits.create(name:"message_source",value:rss.id.to_s)
		assert_equal 1, message.traits.count
		assert_equal 1, rule.traits.count
		assert_equal message.traits.first.name, rule.traits.first.name
		assert rule.any_trait_matches(message)
	end

	test 'any_trait_match: simple trait comparison rule fail' do
		rss = create(:rss_feed)
		rule = create(:rule)
		rule_trait = rule.traits.create(name:"message_source",value:rss.id.to_s)
		message = create(:message)
		message_trait = message.traits.create(name:"message_source",value:(rss.id+1).to_s)
		assert_equal 1, message.traits.count
		assert_equal 1, rule.traits.count
		assert_equal message.traits.first.name, rule.traits.first.name
		assert !rule.any_trait_matches(message)
	end
end 