class AddPreferedTimeToUser < ActiveRecord::Migration
  def change
    add_column :users, :preferred_hour, :integer
    add_column :users, :preferred_min, :integer
    add_column :users, :timezone, :string
  end
end
