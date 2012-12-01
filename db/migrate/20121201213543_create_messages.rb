class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :summary
      t.integer :message_source_id
      t.string :message_source_type
      t.boolean :read
      t.boolean :dismissed

      t.timestamps
    end
  end
end
