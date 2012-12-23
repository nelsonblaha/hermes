# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rule do
    user_id 1
    name "MyRule"
    logic "false"
  end
end
