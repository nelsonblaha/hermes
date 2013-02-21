# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inbox do
    name "MyInbox"
    association :user
    messages_expire false
    
    #10 minute message expiration
    message_expiration_seconds 10*60
  end
end
