class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.belongs_to :sender, index: true, null: false
      t.belongs_to :receiver, index: true, null: false
      t.datetime :read_at, default: nil

      t.timestamps null: false
    end

    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :users, column: :receiver_id
  end
end
