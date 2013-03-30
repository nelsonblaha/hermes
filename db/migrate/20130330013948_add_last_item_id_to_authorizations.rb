class AddLastItemIdToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :last_item_id, :integer, :limit => 8
  end
end
