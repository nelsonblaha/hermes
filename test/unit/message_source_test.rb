require 'test_helper'

class MessageSourceTest < ActiveSupport::TestCase
  test "check" do
  	Message.destroy_all
  	rss_account = create(:rss_feed,user_id:@default.id)
  	user = create(:user)
  	rule = create(:rule,logic:"title.scan(/Ruby/).count > 0",rule_owner_id:user.id,rule_owner_type:'User')
  	#TODO give rule inbox to affect
  	rss_account.check(user)
  	#TODO assert change to rule's inbox
  	assert false, 'incomplete test'
  end
end
