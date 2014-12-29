class AddAttendeesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :attendees, :text
  end
end
