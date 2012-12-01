require 'test_helper'

class RssFeedTest < ActiveSupport::TestCase
  test "new_messages" do
  	rss_account = create(:rss_feed,user_id:@default.id)  	
  	assert_equal 2, rss_account.new_messages.count
  end
end
