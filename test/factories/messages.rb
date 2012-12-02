# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    traits_hash "{'title'=>'Message Hash'}"
    message_source_id 1
    message_source_type "RssFeed"
    read false
    dismissed false
    sequence(:unique_identifier)
  end
end