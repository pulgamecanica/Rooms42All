json.extract! room, :id, :capacity, :is_available?, :name, :location, :is_accessible?, :created_at, :updated_at
json.url room_url(room, format: :json)
