class CreateInboxes < ActiveRecord::Migration
  def change
    create_table :inboxes do |t|
      t.string :name
      t.integer :user_id
      t.boolean :messages_expire
      t.integer :message_expiration_seconds

      t.timestamps
    end
  end
end
