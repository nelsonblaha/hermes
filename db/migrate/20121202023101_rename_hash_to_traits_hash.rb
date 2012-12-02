class RenameHashToTraitsHash < ActiveRecord::Migration
  def change
  	rename_column :messages, :hash, :traits_hash
  end
end
