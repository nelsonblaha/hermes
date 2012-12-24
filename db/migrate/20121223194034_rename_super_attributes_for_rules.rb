class RenameSuperAttributesForRules < ActiveRecord::Migration
  def change
  	change_table :rules do |r|
  		r.rename :super_rule, :parent_rule_id
  		r.rename :super_mode, :children_to_pass
  	end
  end
end
