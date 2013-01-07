require 'test_helper'

class InboxesControllerTest < ActionController::TestCase
  setup do
    @inbox = create(:inbox)
  end

  # scaffolding tests

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:inboxes)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create inbox" do
      assert_difference('Inbox.count') do
        post :create, inbox: attributes_for(:inbox)
      end

      assert_redirected_to root_url
    end

    test "should show inbox" do
      get :show, id: @inbox
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @inbox
      assert_response :success
    end

    test "should update inbox" do
      put :update, id: @inbox, inbox: attributes_for(:inbox)
      assert_redirected_to root_url
    end

    test "should destroy inbox" do
      assert_difference('Inbox.count', -1) do
        delete :destroy, id: @inbox
      end

      assert_redirected_to root_url
    end

  test "should resolve all messages in inbox" do 
    @message = create(:message)
    @rule = create(:rule)
    
    # create a presentation to be resolved
    create(:presentation,message_id:@message.id,inbox_id:@inbox.id)

    # create the template presentation
    create(:presentation,rule_id:@rule.id,inbox_id:@inbox.id)

    # resolve all messages for inbox
    get :resolve_all_messages, id: @inbox
    
    #assert that only the template presentation remains
    assert_equal 1, @inbox.presentations.count
    assert_equal 0, @inbox.messages.count
    assert_redirected_to @inbox
  end

  test "should check inbox for messages" do
    #default test user owns inbox
      @inbox.user_id = @default.id
      @inbox.save

    #default test user owns rss feed
      rss = create(:rss_feed,user_id:@default.id)

    #rule matching rss' messages
      rule = create(:rule,user_id:@default.id)
      trait = create(:trait,traited_id:rule.id,traited_type:'rule',name:'foo',value:'bar')

    #presentation sending rule's messages to @inbox
      create(:presentation,inbox_id:@inbox.id,rule_id:rule.id)

    assert_difference('@inbox.messages.count') do
      rss.check(@default)
    end
  end

end
