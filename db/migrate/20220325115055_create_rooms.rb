class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :capacity
      t.integer :is_available
      t.string :name
      t.text :location
      t.boolean :is_accessible
      t.boolean :has_projector
      t.boolean :audio_system
      t.boolean :had_desk

      t.timestamps
    end
  end
end
