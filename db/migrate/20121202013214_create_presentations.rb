class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.integer :inbox_id
      t.integer :message_id

      t.timestamps
    end
  end
end
