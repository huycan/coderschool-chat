class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true

  has_many :messages, foreign_key: 'receiver_id'

  # friends that invite this user
  has_many :inviter_friendship, foreign_key: :accepter_id, class_name: 'Friendship' 
  has_many :inviter_friends, through: :inviter_friendship, source: :inviter

  # friends that accept invitation of this user
  has_many :accepter_frienship, foreign_key: :inviter_id, class_name: 'Friendship'
  has_many :accepter_friends, through: :accepter_frienship, source: :accepter

  def friends
    [self.inviter_friends.all, self.accepter_friends.all].flatten
  end
end
