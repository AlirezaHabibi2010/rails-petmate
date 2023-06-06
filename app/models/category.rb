class Category < ApplicationRecord
  has_many :pets

  validates_presence_of :name
  validates :name, uniqueness: true
end
