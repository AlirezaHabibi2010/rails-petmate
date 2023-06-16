class Pet < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_type,
                  associated_against: {
                    category: [:name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :search_by_address,
                  associated_against: {
                    user: [:address]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :without_bookings_between_dates,
                  against: [:id],
                  associated_against: {
                    bookings: [:start_time, :end_time]
                  },
                  using: {
                    tsearch: { any_word: true }
                  }

  def self.find_without_bookings_between_dates(start_date, end_date)
    where.not(id: Booking.where(status: ['accepted', 'ongoing']).within_dates(start_date, end_date).select(:pet_id))
  end

  belongs_to :category
  belongs_to :user

  has_many :bookings
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  has_many_attached :photos
  has_many :reviews, through: :bookings

  validates_presence_of :name, :description, :user, :photos, :category
  validates_length_of :description, minimum: 10

  def unavailable_dates
    bookings.where("status= ? AND  end_time > ?", 1, Date.today).pluck(:start_time, :end_time).map do |range|
      { from: range[0], to: range[1] }
    end
  end

  def deactivate!
    update(activated: false)
  end

  def average_rating
    if reviews.empty?
      0
    else
      reviews.average(:rating).round(1)
    end
  end

  def bookmark(user)
    bookmarks.find_by(user: user)
  end
end
