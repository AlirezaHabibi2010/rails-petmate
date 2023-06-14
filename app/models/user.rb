class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :pets
  has_many :bookings
  has_many :messages
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, through: :bookings

  validates_presence_of :first_name, :last_name, :photo, :address, :email
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def bookmarked?(pet)
    bookmarks.map(&:pet).include?(pet)
  end

  def bookmarked_for(pet)
    bookmarks.where(pet: pet).first
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def unread_message_count
    messages.where.not(user_id: id, read: true).count
  end
end
