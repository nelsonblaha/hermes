class AddTemplateToInboxes < ActiveRecord::Migration
  def change
    add_column :inboxes, :template, :string
  end
end
