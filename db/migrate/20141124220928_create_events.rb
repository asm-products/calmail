class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :google_event_id
      t.string :title
      t.text :summary
      t.text :html_link
      t.text :location
      t.datetime :starts_at
      t.datetime :ends_at
      t.text :raw

      t.timestamps
    end
  end
end
