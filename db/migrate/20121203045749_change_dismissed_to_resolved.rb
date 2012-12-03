class ChangeDismissedToResolved < ActiveRecord::Migration
  	def change
  		rename_column :messages, :dismissed, :resolved
 	end
end
