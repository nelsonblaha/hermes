class Message < ActiveRecord::Base
  attr_accessible :dismissed, :message_source_id, :message_source_type, :read, :traits_hash, :unique_identifier

  belongs_to :message_source, polymorphic: true
  has_many :traits, as: :traited
  has_many :inboxes, through: :presentations
end
