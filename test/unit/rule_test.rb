require 'test_helper'

class RuleTest < ActiveSupport::TestCase

	# child_rules_pass?

		test 'child_rules_pass?: pass rule that should pass when all children pass' do
			message = create(:message)
			parent = create(:rule,passing_children_needed_to_pass:0)
			
			2.times do
				rule = create(:rule,parent_rule_id:parent.id)
				rule.stubs(:pass?).returns(true)
			end

			assert parent.child_rules_pass?(message)
		end

		test 'child_rules_pass?: fail rule that should fail when it has a failing child rule' do
			message = create(:message)
			parent = create(:rule,passing_children_needed_to_pass:0)
			
			#passing child rule
			pass_rule = create(:rule,parent_rule_id:parent.id)
			pass_rule.stubs(:pass?).returns(true)

			#failing child rule
			fail_rule = create(:rule,parent_rule_id:parent.id)
			fail_rule.stubs(:pass?).returns(false)
			fail_rule.traits.create(name:"fail",value:"me")

			#debug
			assert_equal false, fail_rule.pass?(message)
			assert_equal 2, Rule.where(parent_rule_id:parent.id).count
			assert_equal false, parent.passing_children_needed_to_pass.nil?
			assert_equal 0, parent.passing_children_needed_to_pass
			parent = Rule.find(parent.id)

			#TODO assert_false?
			assert_equal false, parent.child_rules_pass?(message)
		end

end 