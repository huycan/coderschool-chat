class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.references :user, index: true, null: false
      t.integer :blocked_user_id, index: true, null: false

      t.timestamps null: false
    end

    add_foreign_key :blocks, :users
    add_foreign_key :blocks, :users, column: :blocked_user_id
  end
end
