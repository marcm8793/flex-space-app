class Place < ApplicationRecord
  belongs_to :user

  validates :address_country, presence: true
  validates :address_city, presence: true
  validates :address_street_name, presence: true
  validates :address_zip_code, presence: true
  validates :screen_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :desk_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :bed_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :internet_speed, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :outdoor, inclusion: { in: [true, false] }
  validates :air_conditionning, inclusion: { in: [true, false] }
  validates :price_per_day, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user, presence: true
end
