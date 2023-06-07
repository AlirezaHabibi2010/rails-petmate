# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'

puts "Drop all!"
Booking.destroy_all
Pet.destroy_all
User.destroy_all
Category.destroy_all

def add_image(model, url)
  downloaded_image = URI.parse(URI::Parser.new.escape(url)).open
  if model.respond_to?(:photos)
    model.photos.attach(io: downloaded_image, filename: "avatar.jpg")
  else
    model.update(photos: downloaded_image)
  end
end

puts "Creating categories"
categories = ["Dogs", "Cats", "Birds", "Fish", "Reptiles", "Small Mammals"]

categories.each do |category_name|
  Category.create!(name: category_name)
end

category_ids = Category.ids

puts "Creating users"
user = User.new(email: "aaronsilva95@outlook.es", password: "123456", password_confirmation: "123456", first_name: "Aaron", last_name: "Lorenzo Silva", address: "Ulitzkastr., 13, Cologne, Germany")
url = "https://avatars.githubusercontent.com/u/130074355?v=4"
file = URI.open(url)
user.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
user.save!

user = User.new(email: "martis3007@gmail.com", password: "123456", password_confirmation: "123456", first_name: "Marta", last_name: "Spilnyk", address: "Cologne, Germany")
url = "https://avatars.githubusercontent.com/u/119310647?v=4"
file = URI.open(url)
user.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
user.save!

user = User.new(email: "habibi.alireza2010@gmail.com", password: "123456", password_confirmation: "123456", first_name: "Alireza", last_name: "Habibi", address: "Jülich, Germany", admin: true)
url = "https://avatars.githubusercontent.com/u/87390313?v=4"
file = URI.open(url)
user.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
user.save!

user_ids = User.ids

puts "Creating pets"
descriptions = [
  "Meet the cutest little puppy ever!",
  "This fluffy cat loves to cuddle.",
  "Beautiful parrot with colorful feathers.",
  "A graceful fish that will add beauty to your aquarium.",
  "Friendly reptile looking for a new home.",
  "Adorable hamster that loves to run on the wheel."
]

rand(7..10).times.each do |i|
  puts "Pet number #{i}"
  random_pet_url = "https://source.unsplash.com/random/500x1000/?pet"
  pet = Pet.new(name: Faker::Creature::Dog.name, description: descriptions.sample, user_id: user_ids.sample, category_id: category_ids.sample)
  rand(3..5).times.each do |_|
    add_image(pet, random_pet_url)
    pet.save!
    sleep(1.0)
  end
end

pet_ids = Pet.ids

puts "Creating bookings"
rand(10..15).times.each do
  booking = Booking.new(start_time: Faker::Time.between_dates(from: Date.today + 30, to: Date.today + 60, period: :day), end_time: Faker::Time.between_dates(from: Date.today + 61, to: Date.today + 90, period: :day), pet_id: pet_ids.sample, user_id: user_ids.sample)
  booking.save!
end

puts "Creating reviews"
booking_ids = Booking.ids

rand(50..100).times do
  booking_id = booking_ids.sample
  booking = Booking.find(booking_id)
  # next if booking.reviews

  review = Review.new(
    content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    rating: rand(0..5),
    booking_id: booking_id
  )
  review.save!
end

puts "Creating messages"
rand(10..15).times do
  booking_id = booking_ids.sample
  user_id = user_ids.sample

  message = Message.new(
    content: Faker::Lorem.sentence(word_count: 5, supplemental: true),
    booking_id: booking_id,
    user_id: user_id
  )
  message.save!
end

puts "Creating bookmarks"
rand(5..10).times do
  user_id = user_ids.sample
  pet_id = pet_ids.sample

  bookmark = Bookmark.new(user_id: user_id, pet_id: pet_id)
  bookmark.save!
end
