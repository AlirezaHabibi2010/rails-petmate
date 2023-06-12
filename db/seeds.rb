# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'

puts "Drop all!"
Review.destroy_all
Message.destroy_all
Bookmark.destroy_all
Booking.destroy_all
Pet.destroy_all
Category.destroy_all
User.destroy_all


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

descriptions = {
  "Dogs" => [
    "Meet the cutest little puppy ever!",
    "This fluffy dog loves to cuddle.",
    "Friendly and playful dog looking for a new home."
  ],
  "Cats" => [
    "Adorable cat that loves to nap.",
    "Playful and mischievous cat.",
    "Beautiful and elegant cat seeking a loving owner."
  ],
  "Birds" => [
    "Colorful parrot with vibrant feathers.",
    "Friendly bird that can mimic your voice.",
    "Energetic and intelligent bird."
  ],
  "Fish" => [
    "Beautiful fish that will add tranquility to your aquarium.",
    "Graceful and vibrant fish.",
    "Low-maintenance fish for beginners."
  ],
  "Reptiles" => [
    "Fascinating reptile with unique patterns.",
    "Calm and docile reptile.",
    "Exotic reptile for reptile enthusiasts."
  ],
  "Small Mammals" => [
    "Adorable hamster that loves to run on the wheel.",
    "Cute and cuddly guinea pig.",
    "Playful and curious rabbit."
  ]
}

rand(7..10).times.each do |i|
  puts "Pet number #{i}"
  category_id = category_ids.sample
  category_name = Category.find(category_id).name
  random_pet_url = "https://source.unsplash.com/random/500x1000/?#{category_name.downcase}"

  pet = Pet.new(name: Faker::Creature::Dog.name, description: descriptions[category_name].sample, user_id: user_ids.sample, category_id: category_id)

  rand(3..5).times.each do |_|
    add_image(pet, random_pet_url)
    pet.save!
    sleep(1.0)
  end
end

pet_ids = Pet.ids

puts "Creating bookings"
rand(50..60).times.each do
  booking = Booking.new(start_time: Faker::Time.between_dates(from: Date.today + 30, to: Date.today + 60, period: :day), end_time: Faker::Time.between_dates(from: Date.today + 61, to: Date.today + 90, period: :day), pet_id: pet_ids.sample, user_id: user_ids.sample)
  booking.save!

  review = Review.new(
    content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    rating: rand(0..5),
    booking_id: booking.id
  )
  review.save!
end

puts "Creating reviews"
booking_ids = Booking.ids


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
rand(10..20).times do
  user_id = user_ids.sample
  pet_id = pet_ids.sample

  bookmark = Bookmark.new(user_id: user_id, pet_id: pet_id)
  bookmark.save
end
