require 'test_helper'

class RssFeedTest < ActiveSupport::TestCase
  test "new_messages" do
  	rss_account = create(:rss_feed,user_id:@default.id)  	
  	assert_equal 2, rss_account.new_messages.count
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
