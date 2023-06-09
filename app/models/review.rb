class Review < ApplicationRecord
  belongs_to :booking
  has_one :user, through: :booking
  has_one :pet, through: :booking

  validates_presence_of :content, :booking, :rating
  validates :rating, inclusion: { in: 0..5 }
  validates_length_of :content, minimum: 10
end
