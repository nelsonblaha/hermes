require 'test_helper'

class InboxTest < ActiveSupport::TestCase
  test "check" do
    rss = create(:rss_feed,user_id:@default.id)

    puts 'debug Inbox.count: '+Inbox.count.to_s
    puts 'debug Inbox.first.template: '+Inbox.first.template.to_s

    assert_equal 1, Inbox.count
    inbox = Inbox.first

    assert_difference('inbox.messages.count',2) do
      assert_equal 2, inbox.check
    end

  end
end
