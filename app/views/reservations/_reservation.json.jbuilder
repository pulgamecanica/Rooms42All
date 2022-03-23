json.extract! reservation, :id, :start, :end, :attendees, :subject, :reservation_code, :email, :room_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
