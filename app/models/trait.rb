class Trait < ActiveRecord::Base
  attr_accessible :name, :traited_id, :traited_type, :value

  belongs_to :message, polymorphic: true
  belongs_to :rule, polymorphic: true
end
