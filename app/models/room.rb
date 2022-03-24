class Room < ApplicationRecord
	has_many :reservations
	validates :capacity, presence: true
	validates :name, presence: true
	validates :location, presence: true
	validate :validate_capacity

	def validate_capacity
		if (capacity < 1)
			errors.add(:capacity, "has to be bigger then 0!")
		end
	end
end
