class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer :rule_owner_id
      t.string :rule_owner_type
      t.string :name
      t.integer :mode
      t.string :limit
      t.integer :meta_rule_id
      t.boolean :meta_or_mode

      t.timestamps
    end
  end
end
