class RemoveLogicFromRules < ActiveRecord::Migration
  def up
  	remove_column :rules, :logic
  end

  def down
  	add_column :rules, :logic, :string
  end
end
