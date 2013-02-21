class Message < ActiveRecord::Base
  attr_accessible :resolved, :message_source_id, :message_source_type, :read, :traits_hash, :unique_identifier

  belongs_to :message_source, polymorphic: true
  has_many :traits, as: :traited
  has_many :presentations, dependent: :destroy
  has_many :inboxes, through: :presentations

  def distribute!
    if self.message_source && self.message_source.user
      self.message_source.user.rules.each do |rule|
        rule.process(self)
      end
    end
  end

  def value(name)
  	case name
		when 'message_source_id'
			self.message_source_id
		when 'message_source_type'
			self.message_source_type
		when 'hermes_received_time'
			self.created_at.to_s
		when 'read'
			self.read
		when 'resolved'
			self.resolved
    else
      if trait = self.traits.where(name:name).first
        return self.traits.where(name:name).first.value
      else
        return nil
      end
    end
  end
end
