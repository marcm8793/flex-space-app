class Booking < ApplicationRecord
  belongs_to :place
  belongs_to :user

  validates :first_day, presence: true, date: true
  validates :last_day, presence: true, date: true
  validates :place_id, presence: true
  validates :user_id, presence: true

  validate :last_day_after_first_day

  private

  def last_day_after_first_day
    if last_day <= first_day
      errors.add(:last_day, "must be after the first day")
    end
  end
end
