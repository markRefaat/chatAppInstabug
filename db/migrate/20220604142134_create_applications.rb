class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.string :access_token, null: false
      t.integer :chats_count, default: 0, null: false
      t.timestamps
    end
    add_index :applications, :access_token, unique: true
  end
end
