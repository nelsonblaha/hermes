require 'test_helper'

class RuleTest < ActiveSupport::TestCase

	setup do
		@message = create(:message)
	end

	# child_rules_pass?

		test 'child_rules_pass?: pass rule that should pass when all children pass' do
			parent = create(:rule,passing_children_needed_to_pass:0)
			
			2.times do
				rule = create(:rule,parent_rule_id:parent.id)
				rule.stubs(:pass?).returns(true)
			end

			assert parent.child_rules_pass?(@message)
		end

		test 'child_rules_pass?: fail rule that should fail when it has a failing child rule' do
			parent = create(:rule,passing_children_needed_to_pass:0)
			
			#passing child rule
			pass_rule = create(:rule,parent_rule_id:parent.id)
			pass_rule.stubs(:pass?).returns(true)

			#failing child rule
			fail_rule = create(:rule,parent_rule_id:parent.id,passing_traits_needed_to_pass:1)
			#TODO not working - I set passing_traits_needed_to_pass above instead to ensure failure
				fail_rule.stubs(:pass?).returns(false)
			fail_rule.traits.create(name:"fail",value:"me")

			#TODO assert_false?
			assert_equal false, parent.child_rules_pass?(@message)
		end

		test 'child_rules_pass?: pass rule that should pass when one of two children passes' do
			parent = create(:rule,passing_children_needed_to_pass:1)

			#passing child rule
			pass_rule = create(:rule,parent_rule_id:parent.id)
			pass_rule.stubs(:pass?).returns(true)

			#failing child rule
			fail_rule = create(:rule,parent_rule_id:parent.id)
			fail_rule.stubs(:pass?).returns(false)
			fail_rule.traits.create(name:"fail",value:"me")

			assert parent.child_rules_pass?(@message)
		end

		test 'child_rules_pass?: fail rule that should fail when fewer than one of two children pass' do
			parent = create(:rule,passing_children_needed_to_pass:1)

			#failing child rules
			2.times do
				fail_rule = create(:rule,parent_rule_id:parent.id, passing_traits_needed_to_pass:1)
				#TODO this is not working, so I set passing_traits_needed above to ensure failure
					fail_rule.stubs(:pass?).returns(false)
				fail_rule.traits.create(name:"fail",value:"me")
			end

			assert_equal false, parent.child_rules_pass?(@message)
		end

		test 'child_rules_pass?: pass rule that has no children' do
			parent = create(:rule)
			assert parent.child_rules_pass?(@message)
		end	

		test 'traits_pass?: pass rule that should pass when all traits pass' do
			#TODO
		end

		test 'traits_pass?: fail rule that should fail when it has a failing trait' do
			#TODO
		end

		test 'traits_pass?: fail rule that should pass when one of two traits passes' do
			#TODO
		end

		test 'traits_pass?: fail rule that should fail when fewer than one of two traits pass' do
			#TODO
		end

		test 'traits_pass?: pass rule that has no traits' do
			#TODO
		end

		test 'pass?: pass rule that passes all children and traits' do
			#TODO
		end

		test 'pass?: fail rule that has a failing child' do
			#TODO
		end

		test 'pass?: fail rule that has a failing trait' do
			#TODO
		end

	
end 