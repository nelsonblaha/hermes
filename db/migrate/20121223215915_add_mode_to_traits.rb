class AddModeToTraits < ActiveRecord::Migration
  def change
    add_column :traits, :mode, :integer, default: 1
  end
end
