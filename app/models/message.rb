class Message < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  validates_presence_of :content, :booking, :user
  validates_length_of :content, minimum: 1


  scope :unread_message_number, ->(user) {
    where.not(user_id: user).where.not(read: true).count
  }
end
