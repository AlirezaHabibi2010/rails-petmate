class Message < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  validates_presence_of :content, :booking, :user
  validates_length_of :content, minimum: 1


  scope :unread_message_number, ->(user) {
    where.not(user_id: user).where.not(read: true).count
  }
  # scope :received_message_number, ->(user) {
  #   joins(:bookings).where.not(messages: { user_id: user }).where.not(messages: { read: true }).where(bookings: { user_id: user.id }).count
  # }
end
