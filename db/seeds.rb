require 'faker'

puts "Creating 50 users, 50 places and 50 bookings📈"
# Create 10 users
50.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
    )
end

50.times do
  Place.create(
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
end

50.times do
  start_date = Faker::Date.forward(days: 20)
  end_date = start_date + rand(1..10)

  Booking.create(
    user: User.all.sample,
    place: Place.all.sample,
    first_day: start_date,
    last_day: end_date
  )
end

puts "Finished creating 50 users, 50 places and 50 bookings🎉"
