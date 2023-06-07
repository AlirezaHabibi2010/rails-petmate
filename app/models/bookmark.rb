class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :pet

  validates_presence_of :user, :pet
  validates :user, uniqueness: { scope: :pet } # first_name last_name combination.
end
