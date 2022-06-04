class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.bigint :number, null: false
      t.text :content, null: false
      t.references :chat, null: false, foreign_key: true
      t.timestamps
    end
  end
end
