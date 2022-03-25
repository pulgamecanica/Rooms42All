# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
rooms = 10
reservations = 10

rooms.times do |x|
	room = Room.create!(
			capacity: rand(1..50),
			is_available: true,
			name: Faker::Superhero.power + " " + Faker::ProgrammingLanguage.name,
			location: Faker::Nation.capital_city,
			is_accessible: rand(1..2) % 2 == 0,
			has_projector: rand(1..2) % 2 == 0,
			audio_system: rand(1..3) % 2 == 0,
			had_desk: rand(1..3) % 2 == 0,
		)
	if room.save
		reservations.times do |y|
			start_date = Faker::Date.between(from: 1.days.after, to: 20.days.after).to_datetime
			start_date = start_date.change(hour: rand(0..20))
			start_date = start_date.change(min: rand(0..59))
			start_date = start_date.change(sec: rand(0..59))
			end_date = start_date
			end_date = end_date.change(hour: start_date.hour + 2)
			end_date = end_date.change(min: rand(0..59))
			end_date = end_date.change(sec: rand(0..59))
			res = Reservation.create!(
					t_beginning: start_date,
					t_ending: end_date,
					attendees: rand(1..50),
					subject: Faker::Science.science,
					reservation_code: Faker::Code.npi,
					email: Faker::Internet.email,
					room: room
				)
			res.save
		end
	end
end

#<Reservation:0x00007fcd02e7cd50 id: nil, start: nil, end: nil, attendees: nil, subject: nil, reservation_code: nil, email: nil, room_id: nil, created_at: nil, updated_at: nil> 
#<Room:0x00007fccffdafec0 id: nil, capacity: nil, is_available: nil, name: nil, location: nil, is_accessible: nil, created_at: nil, updated_at: nil>