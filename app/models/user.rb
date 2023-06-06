class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  validates_presence_of :first_name, :last_name, :photo, :address, :email
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
