class AddUtcTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :utc_time, :string
    add_index :users, :utc_time
  end
end
