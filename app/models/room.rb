class Room < ApplicationRecord
	has_many :reservations
	validates :capacity, presence: true
	validates :name, presence: true
	validates :location, presence: true
end
