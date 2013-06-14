# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rss_feed do
    name "MyFeed"
    user
    url "http://hermesbeta.herokuapp.com/sample_rss_for_service_account_test.rss"
  end
end