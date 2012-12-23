class AddSuperRuleToRules < ActiveRecord::Migration
  def change
    add_column :rules, :super_rule, :integer
  end
end
