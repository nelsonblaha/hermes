require 'test_helper'

class TraitTest < ActiveSupport::TestCase
	test 'pass?: pass exact match' do
		green = build(:green_trait)
		assert_equal 1, green.mode
		assert_equal green.value, build(:green_trait).value
		assert green.pass?(build(:green_trait).value)
	end

	test 'pass?: fail non-exact match' do
		green = build(:green_trait)
		blue = build(:trait,name:'color',value:'blue')
		assert !green.pass?(blue.value)
	end
end
