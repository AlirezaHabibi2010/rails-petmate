class Booking < ApplicationRecord
  enum :status, [:pending, :accepted, :declined, :ongoing, :completed]

  belongs_to :pet
  belongs_to :user

  has_one :review
  has_many :messages

  validates_presence_of :start_time, :end_time, :pet, :user, :status
  # validates :status, inclusion: { in: 0..4 }

  validates_comparison_of :start_time, less_than: :end_time, message: 'should be greater than end time date'
  validates_comparison_of :start_time, greater_than_or_equal_to: DateTime.now(), message: 'can be now or future'

  accepts_nested_attributes_for :messages

  def deactivate!
    update(activated: false)
  end

  scope :sorted_by_date, -> { order(start_time: :asc) }

  scope :within_dates, ->(start_date, end_date) {
    where("(start_time, end_time) OVERLAPS (?, ?)", start_date, end_date)
  }
end
