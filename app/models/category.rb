class Category < ApplicationRecord
  has_many :pets

  validates_presence_of :name, :booking, :user
  validates :name, uniqueness: true
end
