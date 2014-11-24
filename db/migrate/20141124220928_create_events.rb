class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :google_event_id
      t.string :title
      t.text :summary
      t.string :status
      t.text :html_link
      t.string :organizer_email
      t.text :creator
      t.text :location
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :disisplay_name
      t.integer :user_id

      t.timestamps
    end
  end
end
