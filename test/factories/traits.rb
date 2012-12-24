# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trait do
    traited_id 1
    traited_type "message"
    mode 1
    name "MyTrait"
    value "MyValue"
    factory :green_trait do
    	name 'color'
    	value 'green'
    end
  end
end
