class Reservation < ApplicationRecord
  belongs_to :room
  validates :start, presence: true
  validates :end, presence: true
  validates :attendees, presence: true
  validates :subject, presence: true
  validates :email, presence: true
  validate :validate_attendees, :validate_date, :validate_email

  def validate_attendees
    if (attendees < 1)
      errors.add(:attendees, "has to be bigger then 0!")
    end
  end

  def validate_date
    if (start >= self.end)
      errors.add(:start, "has to end after it has sarted")
    end
    if (start <= DateTime.now)
      errors.add(:start, "has to be set for after the current time")
    end
  end

  def validate_email
    if not email.include? "@"
      errors.add(:email, "is invalid")
    end
  end
end
