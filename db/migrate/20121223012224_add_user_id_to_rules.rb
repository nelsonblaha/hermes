class AddUserIdToRules < ActiveRecord::Migration
  def change
    add_column :rules, :user_id, :integer
  end
end
