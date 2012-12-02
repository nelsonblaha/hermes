class AddRuleIdToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :rule_id, :integer
  end
end
