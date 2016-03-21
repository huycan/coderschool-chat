class Friendship < ActiveRecord::Base
  belongs_to :inviter, class_name: 'User', foreign_key: 'inviter_id'
  belongs_to :accepter, class_name: 'User', foreign_key: 'accepter_id'

  validate :no_self_friendship

  def no_self_friendship
    errors.add(:accepter_id, 'cannot invite self as friend') if inviter_id == accepter_id
  end
end
