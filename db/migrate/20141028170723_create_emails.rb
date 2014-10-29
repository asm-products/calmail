class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.boolean :delivered, default: false
      t.json :data
      t.references :user, index: true

      t.timestamps
    end
  end
end
