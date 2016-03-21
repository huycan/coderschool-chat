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

  validates :name, length: { minimum: 1 }
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def friends
    [self.inviter_friends.all, self.accepter_friends.all].flatten
  end

  def messages
    self.received_messages.order created_at: :desc
  end

  def add_friend! friend
    self.accepter_friends << friend
  end

  def delete_friend! friend
  end

  def block_friend! friend
  end

  def send_messages! messages
    messages.each do |msg|
      self.sent_messages << msg
    end
  end
end
