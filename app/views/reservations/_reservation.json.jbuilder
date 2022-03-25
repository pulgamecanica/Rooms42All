json.extract! reservation, :id, :room_id, :t_beginning, :t_ending, :attendees, :subject, :reservation_code, :email, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
