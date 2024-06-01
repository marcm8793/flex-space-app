require 'faker'
require 'open-uri'
require 'geocoder'

puts "Creating 21 users, 21 places, and 21 bookings📈"

addresses = [
  { country: "France", city: "Saint-louis", street_name: "45 avenue du Marechal Juin", zip_code: "68300" },
  { country: "Iceland", city: "Reykjavík", street_name: "Kringlan 9", zip_code: "107" },
  { country: "France", city: "NÎmes", street_name: "85 boulevard de Prague", zip_code: "30000" },
  { country: "Norway", city: "Bergen", street_name: "Skostredet 81", zip_code: "5017" },
  { country: "Norway", city: "Hvalstad", street_name: "Johs. Hartmanns vei 213", zip_code: "1395" },
  { country: "Norway", city: "Arendal", street_name: "Lynghaugen 205", zip_code: "4844" },
  { country: "Norway", city: "Sandnes", street_name: "Vestre Hamravei 243", zip_code: "4314" },
  { country: "Norway", city: "Sandnes", street_name: "Lundeleitet 123", zip_code: "4323" },
  { country: "Norway", city: "Oslo", street_name: "Dronning Blancas Vei 1", zip_code: "0287" },
  { country: "Colombia", city: "Cartagena", street_name: "Carrera 55", zip_code: "130004" },
  { country: "New Zealand", city: "Glenross", street_name: "221 Frasers Road", zip_code: "9011", state: "Dunedin" },
  { country: "New Zealand", city: "Pakuranga", street_name: "77 Glenside Avenue", zip_code: "2010", state: "Manukau" },
  { country: "Italy", city: "Grazie", street_name: "Via Galileo Ferraris 142", zip_code: "46040", state: "Mantova" },
  { country: "Switzerland", city: "Meggen", street_name: "Eiholzweg 24", zip_code: "6045" },
  { country: "Switzerland", city: "Dübendorf", street_name: "Kreuzbühlstrasse 10", zip_code: "8600" }
]

21.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end
puts "Created 21 users"

User.create!(
  email: "michelle.mabelle@mail.com",
  password: "password",
  first_name: "Michelle",
  last_name: "Mabelle"
)
puts "Created Michelle Mabelle"

addresses.each do |address|
  full_address = "#{address[:street_name]}, #{address[:city]}, #{address[:zip_code]}, #{address[:country]}"
  coordinates = Geocoder.coordinates(full_address)

  if coordinates
    puts "Geocoded #{full_address}: #{coordinates}"

    place = Place.new(
      address_country: address[:country],
      address_city: address[:city],
      address_street_name: address[:street_name],
      address_zip_code: address[:zip_code],
      latitude: coordinates[0],
      longitude: coordinates[1],
      screen_number: rand(1..10),
      desk_number: rand(1..10),
      bed_number: rand(1..10),
      internet_speed: rand(1..100),
      outdoor: false,
      air_conditionning: false,
      price_per_day: rand(1..500),
      description: Faker::Lorem.paragraph,
      user: User.all.sample
    )

    3.times do |i|
      place.photos.attach(
        io: URI.open("https://source.unsplash.com/featured/500x500/?house&sig=#{SecureRandom.uuid}"),
        filename: "house#{place.id}_#{i + 1}.jpg",
        content_type: "image/jpg"
      )
    end

    place.save!
  else
    puts "Failed to geocode: #{full_address}"
  end
end
puts "Created 21 places"

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
puts "Created 9 bookings"

puts "Finished creating 21 users, 21 places, and 21 bookings🎉"
