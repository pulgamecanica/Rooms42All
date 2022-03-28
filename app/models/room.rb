class Room < ApplicationRecord
	has_many :reservations, dependent: :delete_all
	validates :capacity, presence: true
	validates :name, presence: true
	validates :location, presence: true
	validate :validate_capacity

	  scope :free_schedule, ->(t_start, t_end) {
      # Room.joins(:reservations).where("? > t_beginning OR ? < t_ending", t_start, t_end).or(Room.where(id:  Room.all.select{ |x| x.reservations.count == 0 }.map{ |x| x.id})).distinct
			Room.joins(:reservations).where("? != t_beginning AND ? != t_beginning", t_start, t_end).distinct
    }

	def validate_capacity
		if (capacity.nil? || capacity < 1)
			errors.add(:capacity, "has to be bigger then 0!")
		end
	end
end
