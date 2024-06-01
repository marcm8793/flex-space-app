class Place < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

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
  validates :photos, presence: true
  validates :description, presence: true

  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?

  def favorited_by?(user)
    favorited_by.include?(user)
  end

  def full_address
    [address_street_name, address_city, address_zip_code, address_country].compact.join(', ')
  end

  private

  def address_changed?
    address_country_changed? || address_city_changed? || address_street_name_changed? || address_zip_code_changed?
  end
end
