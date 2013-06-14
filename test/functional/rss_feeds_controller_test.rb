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

  test "create: inbox serving 'news' function is ensured for new rss_feeds to have default structure with" do
    #TODO attempt to use multiple-expression assert_difference to simplify
    #Reset database
      Inbox.destroy_all
      Presentation.destroy_all
      Rule.destroy_all
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
    assert_equal 2, Inbox.count
    assert_equal 2, Presentation.count
    assert_equal 2, Rule.count

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
    put :update, id: @rss_feed, rss_feed: FactoryGirl.attributes_for(:rss_feed)
    assert_redirected_to rss_feed_path(assigns(:rss_feed))
  end

  test "should destroy rss_feed" do
    assert_difference('RssFeed.count', -1) do
      delete :destroy, id: @rss_feed
    end

    assert_redirected_to rss_feeds_path
  end

end
