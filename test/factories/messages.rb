# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    traits_hash "{'title'=>'Message Hash'}"
    message_source_id 1
    message_source_type "RssFeed"
    read false
    resolved false
    sequence(:unique_identifier)
    factory :green_message do
    	after(:create) do |m|
    		m.traits.create(name:'color',value:'green')
    	end		
    end
  end
end
