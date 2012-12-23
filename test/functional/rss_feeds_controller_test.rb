require 'test_helper'

class RssFeedsControllerTest < ActionController::TestCase
  setup do
    @rss_feed = create(:rss_feed)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rss_feeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rss_feed and template if template not present" do
    assert_equal 0, Inbox.count
    assert_equal 0, Presentation.count
    assert_equal 0, Rule.count

    assert_difference('RssFeed.count') do
      post :create, rss_feed: attributes_for(:rss_feed)
    end

    #creation of template inbox, rule, presentation since no template inbox existed
    assert_equal 1, Inbox.count
    assert_equal 1, Presentation.count
    assert_equal 1, Rule.count

    #assocation with existing template inbox when one exists
    create(:rss_feed)
    assert_equal 1, Inbox.count
    assert_equal 2, Presentation.count
    assert_equal 2, Rule.count

    # a message from the latest rss feed goes into the news inbox
    assert_difference('Inbox.first.messages.count') do
      Message.create(message_source:create(:rss_feed))
    end

    # messages from other message sources do not go into the news inbox
    assert_no_difference('Inbox.first.messages.count') do
      
    end

    assert_redirected_to rss_feed_path(assigns(:rss_feed))
  end

  test "should show rss_feed" do
    get :show, id: @rss_feed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rss_feed
    assert_response :success
  end

  test "should update rss_feed" do
    put :update, id: @rss_feed, rss_feed: attributes_for(:rss_feed)
    assert_redirected_to rss_feed_path(assigns(:rss_feed))
  end

  test "should destroy rss_feed" do
    assert_difference('RssFeed.count', -1) do
      delete :destroy, id: @rss_feed
    end

    assert_redirected_to rss_feeds_path
  end
end
