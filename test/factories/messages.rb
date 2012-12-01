# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    summary "Message Summary"
    message_source_id 1
    message_source_type "RssFeed"
    read false
    dismissed false
  end
end
