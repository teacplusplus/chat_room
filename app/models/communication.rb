class Communication < ActiveRecord::Base
  attr_accessible :from_user_id, :to_user_id
  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  has_many :messages

  scope :for_user, ->(user_id) { where(['from_user_id = ? OR to_user_id = ?', user_id, user_id])}

  def self.to_users(communications, user_id)
    result = []
    communications.each do |communication|
      result << communication.from_user_id if user_id != communication.from_user_id
      result << communication.to_user_id if user_id != communication.to_user_id
    end
    result
  end

end
