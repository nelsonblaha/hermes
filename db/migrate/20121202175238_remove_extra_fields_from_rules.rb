class RemoveExtraFieldsFromRules < ActiveRecord::Migration
  def change
  	remove_column :rules, :mode
  	remove_column :rules, :limit
  	remove_column :rules, :meta_or_mode
  	remove_column :rules, :meta_rule_id
  end
end
