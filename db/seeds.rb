require 'faker'
require 'open-uri'

puts "Creating 21 users, 21 places and 21 bookings📈"

addresses = [
  { country: "France", city: "Saint-louis", street_name: "45 avenue du Marechal Juin", zip_code: "68300" },
  { country: "France", city: "Tulle", street_name: "57 avenue Jean Portalis", zip_code: "19000" },
  { country: "France", city: "Maisons-alfort", street_name: "77 avenue Voltaire", zip_code: "64700" },
  { country: "France", city: "Forbach", street_name: "31 Boulevard de Normandie", zip_code: "57600" },
  { country: "France", city: "Malakoff", street_name: "17 avenue Voltaire", zip_code: "92240" },
  { country: "France", city: "NÎmes", street_name: "85 boulevard de Prague", zip_code: "30000" },
  { country: "Norway", city: "Bergen", street_name: "Skostredet 81", zip_code: "5017" },
  { country: "Norway", city: "Drammen", street_name: "Veibrekk 66", zip_code: "3032" },
  { country: "Norway", city: "Hvalstad", street_name: "Johs. Hartmanns vei 213", zip_code: "1395" },
  { country: "Norway", city: "Arendal", street_name: "Lynghaugen 205", zip_code: "4844" },
  { country: "Norway", city: "Sandnes", street_name: "Vestre Hamravei 243", zip_code: "4314" },
  { country: "Norway", city: "Sandnes", street_name: "Lundeleitet 123", zip_code: "4323" },
  { country: "New Zealand", city: "Whenuapai", street_name: "206 Kingsway Road", zip_code: "0618", state: "Waitakere" },
  { country: "New Zealand", city: "Waimataitai", street_name: "53 Dobson Street", zip_code: "7910", state: "Timaru" },
  { country: "New Zealand", city: "Torbay", street_name: "194 Huntly Road", zip_code: "0630", state: "North Shore" },
  { country: "New Zealand", city: "Glenross", street_name: "221 Frasers Road", zip_code: "9011", state: "Dunedin" },
  { country: "New Zealand", city: "Pakuranga", street_name: "77 Glenside Avenue", zip_code: "2010", state: "Manukau" },
  { country: "New Zealand", city: "Paraparaumu Beach", street_name: "209 Wood Leigh", zip_code: "5032", state: "Paraparaumu" },
  { country: "Italy", city: "Grazie", street_name: "Via Galileo Ferraris 142", zip_code: "46040", state: "Mantova" },
  { country: "Italy", city: "Cormons", street_name: "Via Medina 125", zip_code: "34071", state: "Gorizia" },
  { country: "Italy", city: "Brogliano", street_name: "Lungodora Napoli 81", zip_code: "36070", state: "Vicenza" }
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
  place = Place.new(
    address_country: address[:country],
    address_city: address[:city],
    address_street_name: address[:street_name],
    address_zip_code: address[:zip_code],
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

puts "Finished creating 21 users, 21 places and 21 bookings🎉"
