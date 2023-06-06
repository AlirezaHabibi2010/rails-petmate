class Pet < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :bookings
  has_many_attached :photos

  validates_presence_of :name, :description, :user, :photos, :category
  validates_length_of :description, minimum: 10
end
