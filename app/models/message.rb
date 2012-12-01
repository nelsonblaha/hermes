class Message < ActiveRecord::Base
  attr_accessible :dismissed, :message_source_id, :message_source_type, :read, :summary
end
