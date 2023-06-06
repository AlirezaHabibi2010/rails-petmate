class Message < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  validates_presence_of :content, :booking, :user
  validates_length_of :content, minimum: 1
end
