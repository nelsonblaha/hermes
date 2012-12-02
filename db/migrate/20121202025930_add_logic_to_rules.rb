class AddLogicToRules < ActiveRecord::Migration
  def change
    add_column :rules, :logic, :text
  end
end
