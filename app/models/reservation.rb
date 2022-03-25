class Reservation < ApplicationRecord
  belongs_to :room
  validates :t_beginning, presence: true
  validates :t_ending, presence: true
  validates :attendees, presence: true
  validates :subject, presence: true
  validates :email, presence: true
  validate :validate_attendees, :validate_date, :validate_email


  scope :active_reservations, -> do
    where(finished: false)
  end

  def validate_attendees
    if (attendees.nil? or attendees < 1)
      errors.add(:attendees, "has to be bigger then 0!")
    end
  end

  def validate_date
    if (t_beginning.nil? or t_ending.nil? or t_beginning >= t_ending)
      errors.add(:t_beginning, "has to end after it has sarted")
    end
    if (t_beginning.nil? or t_beginning <= DateTime.now)
      errors.add(:t_beginning, "has to be set for after the current time")
    end
  end

  def validate_email
    if email.nil?
      errors.add(:email, "is blank")
    elsif not email.include? "@"
      errors.add(:email, "is invalid")
    end
  end
end

