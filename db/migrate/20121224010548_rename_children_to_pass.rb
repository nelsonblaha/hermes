class RenameChildrenToPass < ActiveRecord::Migration
  def change
  	rename_column :rules, :children_to_pass, :passing_children_needed_to_pass
  end
end
