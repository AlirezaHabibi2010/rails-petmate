class Booking < ApplicationRecord
  belongs_to :pet
  belongs_to :user

  has_many :messages
  has_many :reviews
end
