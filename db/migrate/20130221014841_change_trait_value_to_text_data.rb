class ChangeTraitValueToTextData < ActiveRecord::Migration
  def change
    change_table :traits do |t|
      t.change :value, :text
    end
  end
end