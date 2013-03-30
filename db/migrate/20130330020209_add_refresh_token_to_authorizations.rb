class AddRefreshTokenToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :refresh_token, :string
  end
end
