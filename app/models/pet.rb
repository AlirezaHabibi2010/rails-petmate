class Pet < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many_attached :photos

  has_many :bookings
end
