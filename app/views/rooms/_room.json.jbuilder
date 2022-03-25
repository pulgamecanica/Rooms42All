json.extract! room, :id, :capacity, :is_available, :name, :location, :is_accessible, :has_projector, :audio_system, :had_desk, :created_at, :updated_at
json.url room_url(room, format: :json)
