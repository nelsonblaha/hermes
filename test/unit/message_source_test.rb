require 'test_helper'

class MessageSourceTest < ActiveSupport::TestCase
  test "check" do
  	rss_account = create(:rss_feed,user_id:@default.id)
  	user = create(:user)
  	rule = create(:rule,logic:"title.scan(/Ruby/).count > 0",rule_owner_id:user.id,rule_owner_type:'User')
    inbox = create(:inbox)
    create(:presentation,rule_id:rule.id,inbox_id:inbox.id)
    assert_difference('inbox.messages.count',+2) do
  	 rss_account.check(user)
    end
  end
end
