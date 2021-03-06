class User < ActiveRecord::Base
  has_secure_password

  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'

  # friends that invite this user
  has_many :inviter_friendship, foreign_key: :accepter_id, class_name: 'Friendship' 
  has_many :inviter_friends, through: :inviter_friendship, source: :inviter

  # friends that accept invitation of this user
  has_many :accepter_friendship, foreign_key: :inviter_id, class_name: 'Friendship'
  has_many :accepter_friends, through: :accepter_friendship, source: :accepter

  has_many :blocks, foreign_key: 'user_id'
  has_many :blocked_friends, through: :blocks, source: 'blocked_user'

  validates :name, length: { minimum: 1 }
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  scope :all_except, ->(user) { where.not(id: user) }

  def friends
    [self.inviter_friends.all, self.accepter_friends.all].flatten
  end

  def users_to_add_friend
    User.all_except(self[:id])
  end

  def is_friend_of? user_id
    return !!Friendship.find_by(inviter_id: user_id, accepter_id: self[:id]) || !!Friendship.find_by(inviter_id: self[:id], accepter_id: user_id)
  end

  def is_blocked_by? user_id
    return !!Block.find_by(user_id: user_id, blocked_user_id: self[:id])
  end

  def messages
    self.received_messages.blocked_by_sender(self.blocked_friends.collect { |f| f.id }).order created_at: :desc
  end

  def ordered_sent_messages
    self.sent_messages.order created_at: :desc
  end

  def add_friend! friend
    self.accepter_friends << friend
  end

  def delete_friend! friend
    self.inviter_friends.destroy friend
    self.accepter_friends.destroy friend
    # Friendship.destroy_all inviter_id: friend.id, accepter_id: self[:id]
    # Friendship.destroy_all inviter_id: self[:id], accepter_id: friend.id
  end

  def block_friend! friend
    self.blocked_friends << friend
  end

  def unblock_friend! friend
    self.blocked_friends.destroy friend
  end

  def send_messages! message
    self.sent_messages << message
    # return self.sent_messages.last
  end
end
