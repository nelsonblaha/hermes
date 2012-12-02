# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trait do
    traited_id 1
    traited_type "message"
    name "MyTrait"
    value "MyValue"
  end
end
