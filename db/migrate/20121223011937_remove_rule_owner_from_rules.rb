class RemoveRuleOwnerFromRules < ActiveRecord::Migration
  def up
  	remove_column :rules, :rule_owner_id
  	remove_column :rules, :rule_owner_type
  end

  def down
  	add_column :rules, :rule_owner_id, :integer
  	add_column :rules, :rule_owner_type, :string
  end
end
