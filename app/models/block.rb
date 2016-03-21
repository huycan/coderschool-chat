class Block < ActiveRecord::Base
  belongs_to :user
  belongs_to :blocked_user, class_name: 'User', foreign_key: 'blocked_user_id'

  validates :user_id, presence: true
  validates :blocked_user_id, presence: true

  validate :no_self_block

  def no_self_block
    errors.add(:blocked_user_id, 'cannot block self') if user_id == blocked_user_id
  end
end
