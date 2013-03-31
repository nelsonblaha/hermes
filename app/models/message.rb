class Message < ActiveRecord::Base
  attr_accessible :resolved, :message_source_id, :message_source_type, :read, :traits_hash, :unique_identifier

  belongs_to :message_source, polymorphic: true
  has_many :traits, as: :traited, dependent: :destroy
  has_many :presentations, dependent: :destroy
  has_many :inboxes, through: :presentations

  def source
    if self.message_source_type == "RssFeed"
      self.message_source.name+" (RSS)"
    elsif self.message_source_type == "Authorization"
      "@"+self.traits.where(name:"user_screen_name").first.value
    end
  end

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

  def message_subject
    if trait = Trait.where(traited_type:'Message',traited_id:self.id,name:'title').first
     trait.value
    else
      "unknown subject"
    end
  end
end
