class AddTraitAttributesToRules < ActiveRecord::Migration
  def change
    add_column :rules, :passing_traits_needed_to_pass, :integer
  end
end
