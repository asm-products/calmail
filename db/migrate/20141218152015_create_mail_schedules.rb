class CreateMailSchedules < ActiveRecord::Migration
  def change
    remove_column :users, :preferred_hour
    remove_column :users, :preferred_min
    remove_column :users, :timezone
    remove_column :users, :utc_time

    create_table :mail_schedules do |t|
      t.integer :preferred_hour
      t.integer :preferred_min
      t.string :timezone
      t.string :utc_time
      t.integer :user_id

      t.timestamps
    end

    add_index :mail_schedules, :user_id
  end
end
