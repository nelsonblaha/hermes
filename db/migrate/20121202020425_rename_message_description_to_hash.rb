class RenameMessageDescriptionToHash < ActiveRecord::Migration
  def change
  	rename_column :messages, :summary, :hash
  end
end
