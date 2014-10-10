class AddNameAndTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :first_name, :string
    add_column :users, :token, :string
  end
end
