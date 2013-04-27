require 'test_helper'

class RssFeedTest < ActiveSupport::TestCase

  test "default_present_to_news_inbox_template" do
    assert_difference(['Inbox.count','Rule.count']) { create(:rss_feed,name:"New Feed",user_id:@default.id) }
    assert_equal 'Send all messages from source: New Feed (RSS Feed) to inbox: News', Rule.last.name
    assert_equal Rule.last.user_id, Inbox.last.user_id
    assert_equal "news", Inbox.last.template
    assert_difference("Rule.count") do
      assert_no_difference("Inbox.count") { create(:rss_feed, name:"Another New Feed",user_id:@default.id) }
    end
    new_user = create(:user)
    assert_difference(["Rule.count","Inbox.count"]) { create(:rss_feed, name:"Second user's feed 1",user_id:new_user.id) }
    assert_difference("Rule.count") do
      assert_no_difference("Inbox.count") { create(:rss_feed, name:"Second user's feed 2",user_id:new_user.id) }
    end
  end

  test "new rss_feed always has 'news' template inbox delivery structure created" do
  	Inbox.destroy_all
  	
    assert_difference(['@default.inboxes.count','Presentation.count','Rule.count']) do
  		rss_account = create(:rss_feed,user_id:@default.id)
  	end

    assert_equal 'News',Inbox.first.name
    rss_account = create(:rss_feed,user_id:@default.id)
  end

  test "changing name of template 'News' inbox does not change its role as default News inbox" do 
    create(:rss_feed,user_id:@default.id)

    assert_no_difference('Inbox.count') do
      create(:rss_feed,user_id:@default.id)
    end

    assert_equal 1, Inbox.where(template:'news').count
  end
end
