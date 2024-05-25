require 'faker'
require 'open-uri'

puts "Creating 50 users, 50 places and 50 bookings📈"
puts "Create 10 users"

# URLs for the images to be attached
image_urls = [
  'https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg',
  'https://images.pexels.com/photos/164558/pexels-photo-164558.jpeg?auto=compress&cs=tinysrgb&w=800', # You can replace these with different URLs
  'https://images.pexels.com/photos/1438832/pexels-photo-1438832.jpeg?auto=compress&cs=tinysrgb&w=800'  # You can replace these with different URLs
]


9.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
    )
end

User.create!(
email: "michelle.mabelle@mail.com",
password: "password",
first_name: "Michelle",
last_name: "Mabelle"
)

User.create!(
email: "michelle.mabelle2@mail.com",
password: "password",
first_name: "Michelle2",
last_name: "Mabelle"
)


9.times do
  place = Place.new(
    address_country: Faker::Address.country,
    address_city: Faker::Address.city,
    address_street_name: Faker::Address.street_name,
    address_zip_code: Faker::Address.zip_code,
    screen_number: rand(1..10),
    desk_number: rand(1..10),
    bed_number: rand(1..10),
    internet_speed: rand(1..100),
    outdoor: false,
    air_conditionning: false,
    price_per_day: rand(1..500),
    user: User.all.sample
  )


  # Attach each image to the place
  image_urls.each do |url|
    file = URI.open(url)
    place.photos.attach(io: file, filename: File.basename(URI.parse(url).path))
  end

  place.save!
end

9.times do
  start_date = Faker::Date.forward(days: 20)
  end_date = start_date + rand(1..10)

  Booking.create(
    user: User.all.sample,
    place: Place.all.sample,
    first_day: start_date,
    last_day: end_date
  )
end

puts "Finished creating 20 users, 20 places and 20 bookings🎉"
