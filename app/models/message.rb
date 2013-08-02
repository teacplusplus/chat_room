class Message < ActiveRecord::Base
  attr_accessible :body, :communication_id, :user_id
  validates :communication_id, presence: true

  belongs_to :communication
  scope :communication, ->(communication_id) { where(communication_id: communication_id) }
end
