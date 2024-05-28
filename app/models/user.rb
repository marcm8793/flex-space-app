class User < ApplicationRecord
  has_many :places
  has_many :bookings
  has_many :favorites, dependent: :destroy
  has_many :favorite_places, through: :favorites, source: :place
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, presence: true
  validates :last_name, presence: true
end
