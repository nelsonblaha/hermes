class Presentation < ActiveRecord::Base
  attr_accessible :inbox_id, :message_id, :rule_id

  belongs_to :inbox
  belongs_to :message
  belongs_to :rule
end
