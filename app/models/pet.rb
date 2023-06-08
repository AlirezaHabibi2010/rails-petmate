class Pet < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :bookings
  has_many :bookmark
  has_many_attached :photos
  has_many :reviews, through: :bookings

  validates_presence_of :name, :description, :user, :photos, :category
  validates_length_of :description, minimum: 10

  def unavailable_dates
    bookings.where("status= ? AND  end_time > ?", 1, Date.today).pluck(:start_time, :end_time).map do |range|
      { from: range[0], to: range[1] }
    end
  end

  def average_rating
    if reviews.empty?
      0
    else
      reviews.average(:rating).round
    end
  end
end
