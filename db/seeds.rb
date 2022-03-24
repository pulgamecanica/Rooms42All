# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do |x|
	room = Room.create!(
			capacity: rand(1..50),
			is_available: true,
			name: Faker::Superhero.power + " " + Faker::ProgrammingLanguage.name,
			location: Faker::Nation.capital_city,
			is_accessible: rand(1..2) % 2 == 0,
		)
	if room.save
		3.times do |y|
			start_date = Faker::Date.between(from: 2.days.ago, to: 1.days.ago).to_datetime
			start_date = start_date.change(hour: rand(0..23))
			start_date = start_date.change(min: rand(0..59))
			start_date = start_date.change(sec: rand(0..59))
			end_date = Faker::Date.between(from: start_date, to: Date.today).to_datetime
			end_date = end_date.change(hour: start_date.hour + 1)
			end_date = end_date.change(min: rand(0..59))
			end_date = end_date.change(sec: rand(0..59))
			Reservation.create!(
					start: start_date,
					end: end_date,
					attendees: rand(1..50),
					subject: Faker::Science.science,
					reservation_code: Faker::Code.npi,
					email: Faker::Internet.email,
					room: room
				)
		end
	end
end

#<Reservation:0x00007fcd02e7cd50 id: nil, start: nil, end: nil, attendees: nil, subject: nil, reservation_code: nil, email: nil, room_id: nil, created_at: nil, updated_at: nil> 
#<Room:0x00007fccffdafec0 id: nil, capacity: nil, is_available: nil, name: nil, location: nil, is_accessible: nil, created_at: nil, updated_at: nil>