class AddDefaultZeroToRulesTraitsNeededToPass < ActiveRecord::Migration
  def change
  	remove_column :rules, :traits_to_pass
  	add_column :rules, :passing_traits_needed_to_pass, :integer, default: 0
  end
end
