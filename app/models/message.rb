class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :content, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  before_create :set_unread!

  def read?
    !!self[:read_at]
  end

  def read_at_utc time
    if self[:read_at].nil?
      self[:read_at] = time.utc
    end
  end

  private
  def set_unread!
    self[:read_at] = nil
  end
end
