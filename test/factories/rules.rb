# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rule do
    rule_owner_id 1
    rule_owner_type "user"
    name "MyRule"
    logic ""
  end
end
