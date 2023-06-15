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

###################################################################
puts "Creating categories"
categories = ["Dogs", "Cats", "Birds", "Fish", "Reptiles", "Small Mammals"]
categories.each do |category_name|
  Category.create!(name: category_name)
end
category_ids = Category.ids
require 'open-uri'

###################################################################
puts "Creating users"

addresses = [
  "Königsallee 11, 40212 Düsseldorf, Germany",
  "Burgplatz 4, 40213 Düsseldorf, Germany",
  "Schadowstraße 11, 40212 Düsseldorf, Germany",
  "Rheinuferpromenade 1, 40213 Düsseldorf, Germany",
  "Hofgartenstraße 1, 40213 Düsseldorf, Germany",
  "Domkloster 4, 50667 Cologne, Germany",
  "Heumarkt 20, 50667 Cologne, Germany",
  "Kartäusergasse 1, 50678 Cologne, Germany",
  "Severinstraße 198, 50676 Cologne, Germany",
  "Rheinauhafen 1, 50678 Cologne, Germany",
  "Adenauerallee 79-81, 53113 Bonn, Germany",
  "Berliner Freiheit 18, 53111 Bonn, Germany",
  "Poppelsdorfer Allee 49, 53115 Bonn, Germany",
  "Maximilianstraße 28, 53111 Bonn, Germany",
  "Bonngasse 20, 53111 Bonn, Germany",
  "Hauptstraße 12, 42103 Wuppertal, Germany",
  "Mühlenweg 7, 42107 Wuppertal, Germany",
  "Rheinuferstraße 21, 42119 Wuppertal, Germany",
  "Bergstraße 15, 42109 Wuppertal, Germany",
  "Domplatz 3, 42117 Wuppertal, Germany"
]


# Add 20 random user accounts
20.times do |index|
  user = User.new(
    email: Faker::Internet.email,
    password: "123456",
    password_confirmation: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: addresses[index],
    admin: false
  )
  # Assign a random avatar image to the user
  avatar_url = "https://randomuser.me/api/portraits/#{['men', 'women'].sample}/#{rand(1..99)}.jpg"
  downloaded_image = URI.parse(URI::Parser.new.escape(avatar_url)).open
  user.photo.attach(io: downloaded_image, filename: "avatar.jpg")
  user.save!
end

user_ids = User.ids
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

10.times.each do |i|
  puts "Pet number #{i}"
  category_id = category_ids.sample
  category_name = Category.find(category_id).name
  random_pet_url = "https://source.unsplash.com/random/500x1000/?#{category_name.gsub(" ", "_").downcase}"
  pet = Pet.new(name: Faker::Creature::Dog.name, description: descriptions[category_name].sample, user_id: user_ids.sample, category_id: category_id)
  rand(3..5).times.each do |_|
    add_image(pet, random_pet_url)
    pet.save!
    sleep 1
  end
end
pet_ids = Pet.ids
puts "Creating bookings"

pet_category_reviews = {
    "Dogs" => [
      "I had an amazing time with %{pet_name}, such a lovely dog!",
      "Spending time with %{pet_name} was pure joy, such a playful companion!",
      "Taking care of %{pet_name} was a wonderful experience, a truly special dog!",
      "I can't express how much I enjoyed my time with %{pet_name}, an absolute sweetheart!",
      "The moments spent with %{pet_name} will always be cherished, a fantastic dog!",
      "Words cannot describe the happiness %{pet_name} brought into my life, a remarkable companion!",
      "I'm grateful for the opportunity to have met and cared for %{pet_name}, an exceptional dog!",
      "Playing and bonding with %{pet_name} was a highlight of my day, such a lovable pet!",
      "Looking after %{pet_name} was a pleasure, a truly amazing dog!",
      "I'll never forget the memories made with %{pet_name}, a remarkable canine friend!"
    ],
    "Cats" => [
      "I had a great experience with %{pet_name}, such an adorable cat!",
      "Taking care of %{pet_name} was a delight, a truly charming feline!",
      "The company of %{pet_name} brought me so much joy, an amazing cat!",
      "Cuddling with %{pet_name} was the best, a sweet and affectionate companion!",
      "I fell in love with %{pet_name} the moment I saw them, a truly special cat!",
      "Being around %{pet_name} was a calming and peaceful experience, a lovely feline friend!",
      "I'll always remember the playful moments I shared with %{pet_name}, a fantastic cat!",
      "Meeting and getting to know %{pet_name} was a privilege, an extraordinary cat!",
      "Taking care of %{pet_name} was a heartwarming experience, an adorable and gentle cat!",
      "Spending time with %{pet_name} made me appreciate the unique nature of cats, a wonderful pet!"
    ],
    "Birds" => [
      "I enjoyed spending time with %{pet_name}, a colorful and intelligent bird!",
      "Meeting %{pet_name} was a unique experience, a beautiful feathered friend!",
      "The vibrant presence of %{pet_name} brightened up my day, a truly captivating bird!",
      "Observing the intelligence of %{pet_name} was fascinating, a remarkable feathered companion!",
      "Taking care of %{pet_name} allowed me to appreciate the beauty of birds, an incredible pet!",
      "The melodic sounds of %{pet_name}'s chirping brought tranquility, a delightful bird!",
      "I'll always remember the charming personality of %{pet_name}, a wonderful feathered friend!",
      "Bonding with %{pet_name} was an enriching experience, an intelligent and curious bird!",
      "Having the opportunity to care for %{pet_name} was a privilege, an extraordinary bird!",
      "The playful nature of %{pet_name} made every moment enjoyable, a fantastic feathered companion!"
    ],
    "Fish" => [
      "I had a peaceful time observing %{pet_name} swimming in the aquarium!",
      "Watching %{pet_name} glide gracefully through the water was mesmerizing!",
      "The calming presence of %{pet_name} brought tranquility to the aquarium, a beautiful fish!",
      "Taking care of %{pet_name} was a low-maintenance and rewarding experience, a lovely fish!",
      "The vibrant colors of %{pet_name} added beauty to the aquarium, a mesmerizing fish!",
      "Caring for %{pet_name} was a soothing and therapeutic experience, a graceful swimmer!",
      "I'll always remember the tranquility %{pet_name} brought into my home, a wonderful fish!",
      "The unique patterns of %{pet_name} made it stand out, a truly captivating fish!",
      "Having %{pet_name} as a pet was a great way to appreciate the wonders of aquatic life!",
      "Observing the behaviors of %{pet_name} was a fascinating experience, an extraordinary fish!"
    ],
    "Reptiles" => [
      "I learned a lot about reptiles while taking care of %{pet_name}, a fascinating creature!",
      "Caring for %{pet_name} allowed me to appreciate the beauty of reptiles!",
      "Meeting %{pet_name} was an opportunity to learn more about reptiles, a unique companion!",
      "The calm and docile nature of %{pet_name} made it easy to bond with, an incredible reptile!",
      "Taking care of %{pet_name} was an exciting and educational experience, a wonderful reptile!",
      "The unique patterns and textures of %{pet_name}'s skin were mesmerizing, a remarkable reptile!",
      "Bonding with %{pet_name} was a special experience, a fascinating reptilian friend!",
      "I'll always cherish the memories made with %{pet_name}, a captivating reptile companion!",
      "Having %{pet_name} as a pet broadened my understanding and appreciation for reptiles!",
      "Taking care of %{pet_name} was an adventure, an extraordinary reptilian companion!"
    ],
    "Small Mammals" => [
      "I loved playing with %{pet_name}, such a cute and friendly small mammal!",
      "Taking care of %{pet_name} brought me so much happiness, an adorable little companion!",
      "The playful nature of %{pet_name} made every moment enjoyable, a delightful small mammal!",
      "Bonding with %{pet_name} was a heartwarming experience, a truly charming pet!",
      "Spending time with %{pet_name} was a joy, a lovable and cuddly small mammal!",
      "I'll always remember the curious and inquisitive personality of %{pet_name}, a fantastic pet!",
      "Having %{pet_name} as a companion added so much warmth and happiness to my life!",
      "The energy and liveliness of %{pet_name} made it impossible not to smile, a wonderful small mammal!",
      "Taking care of %{pet_name} was a rewarding experience, a truly special and adorable pet!",
      "The gentle and affectionate nature of %{pet_name} made it a perfect cuddle buddy, an amazing small mammal!"
    ]
}

rand(40..50).times.each do
  booking = Booking.new(
      start_time: Faker::Time.between_dates(
        from: Date.today + 30, to: Date.today + 60, period: :day
      ).change(sec: 0, min: 0), # Remove seconds from the start_time
      end_time: Faker::Time.between_dates(
        from: Date.today + 61, to: Date.today + 90, period: :day
      ).change(sec: 0, min: 0), # Remove seconds from the end_time
      pet_id: pet_ids.sample,
      user_id: user_ids.sample
    )
  booking.status = "completed"
  booking.save!

  # add review
  pet = booking.pet
  category_name = pet.category.name
  pet_name = pet.name
  review = Review.new(
    content: pet_category_reviews[category_name].sample.gsub('%{pet_name}', pet_name),
    rating: rand(2..5),
    booking_id: booking.id
  )
  review.save!

  puts "Creating messages"
  rand(10..15).times do
    booking_id = booking.id
    user_id = pet.user.id
    message = Message.new(
      content: Faker::Lorem.sentence(word_count: 5, supplemental: true),
      booking_id: booking_id,
      user_id: user_id
    )
    message.save!
  end
end



puts "Creating bookmarks"
rand(10..20).times do
  user_id = user_ids.sample
  pet_id = pet_ids.sample
  bookmark = Bookmark.new(user_id: user_id, pet_id: pet_id)
  bookmark.save
end


################################################################################
puts "Creating main users"

user = User.new(email: "aaronsilva95@outlook.es", password: "123456", password_confirmation: "123456", first_name: "Aaron", last_name: "Lorenzo Silva", address: "Ulitzkastr., 13, 50931 Cologne, Germany", admin: true)
url = "https://avatars.githubusercontent.com/u/130074355?v=4"
file = URI.open(url)
user.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
user.save!

user = User.new(email: "martis3007@gmail.com", password: "123456", password_confirmation: "123456", first_name: "Marta", last_name: "Spilnyk", address: "Aachener Str. 289, 50931 Cologne, Germany", admin: false)
url = "https://avatars.githubusercontent.com/u/119310647?v=4"
file = URI.open(url)
user.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
user.save!

user = User.new(email: "habibi.alireza2010@gmail.com", password: "123456", password_confirmation: "123456", first_name: "Alireza", last_name: "Habibi", address: "Clarenbachstraße 184, 50931 Cologne, Germany", admin: false)
url = "https://avatars.githubusercontent.com/u/87390313?v=4"
file = URI.open(url)
user.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
user.save!

user_ali_id = user.id

cat_url = [
  "https://catsplace.org/wp-content/uploads/2015/02/khaomanee-khao-manee-cat-breed.jpg",
  "https://www.warrenphotographic.co.uk/photography/cats/49814.jpg",
  "https://static.standard.co.uk/s3fs-public/thumbnails/image/2018/08/08/11/elaine-and-sam.jpg?width=1024&auto=webp&quality=50&crop=968%3A645%2Csmart",
  "https://www.mediastorehouse.co.uk/p/172/cat-khao-manee-11753307.jpg.webp",
  "https://img.myloview.com/stickers/close-up-portrait-of-a-white-cat-with-heterochromia-odd-eyes-wearing-a-pink-collar-with-bell-looking-directly-at-viewer-with-curious-expression-400-204673265.jpg"
]

category_id =  Category.find_by(name: "Cats").id
category_name = Category.find(category_id).name
random_pet_url = "https://source.unsplash.com/random/500x1000/?#{category_name.downcase}"
pet = Pet.new(name: "fluffy", description: descriptions[category_name].sample, user_id: user_ali_id, category_id: category_id)
cat_url.each do |url|
  add_image(pet, url)
  pet.save!
end
special_pet_id = pet.id

5.times.each do
  booking = Booking.new(
    start_time: Faker::Time.between_dates(
      from: Date.today + 1, to: Date.today + 30, period: :day
    ).change(sec: 0, min: 0), # Remove seconds from the start_time
    end_time: Faker::Time.between_dates(
      from: Date.today + 10 , to: Date.today + 50, period: :day
    ).change(sec: 0, min: 0), # Remove seconds from the end_time
    pet_id: special_pet_id,
    user_id: user_ids.sample
  )
  booking.status = "completed"
  if booking.save
    # add review
    pet = booking.pet
    category_name = pet.category.name
    pet_name = pet.name
    review = Review.new(
      content: pet_category_reviews[category_name].sample.gsub('%{pet_name}', pet_name),
      rating: rand(3..5),
      booking_id: booking.id
    )
    review.updated_at = review.booking.end_time
    review.save!
  end
end
