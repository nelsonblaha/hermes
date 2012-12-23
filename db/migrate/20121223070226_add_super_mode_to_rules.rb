class AddSuperModeToRules < ActiveRecord::Migration
  def change
    add_column :rules, :super_mode, :integer
  end
end
