class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.belongs_to :inviter, index: true, null: false
      t.belongs_to :accepter, index: true, null: false

      t.timestamps null: false
    end

    add_foreign_key :friendships, :users, column: :inviter_id
    add_foreign_key :friendships, :users, column: :accepter_id
  end
end
