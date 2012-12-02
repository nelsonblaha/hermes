class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.integer :traited_id
      t.string :traited_type
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
