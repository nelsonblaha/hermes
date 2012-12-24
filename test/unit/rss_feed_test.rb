require 'test_helper'

class RssFeedTest < ActiveSupport::TestCase
  test "new_messages" do
  	rss_account = create(:rss_feed,user_id:@default.id)  	
  	assert_equal 2, rss_account.new_messages.count
  end

  test "default_present_to_news_inbox_template" do
  	Inbox.destroy_all
  	assert_difference(['@default.inboxes.count','Presentation.count','Rule.count']) do
  		rss_account = create(:rss_feed,user_id:@default.id)
  	end
  end
end
