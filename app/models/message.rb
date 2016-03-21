class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :content, presence: true
  validates :sender, presence: true
  validates :receiver, presence: true

  before_create :set_unread

  def read?
    !!self[:read_at]
  end

  def read at_utc_time
    if self[:read_at].nil?
      self[:read_at] = at_utc_time.utc
    end
  end

  private
  def set_unread
    self[:read_at] = nil
  end
end
