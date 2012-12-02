class AddUniqueIdentifierToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :unique_identifier, :string
  end
end
