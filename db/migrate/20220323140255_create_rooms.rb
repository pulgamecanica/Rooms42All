class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :capacity
      t.boolean :is_available
      t.string :name
      t.text :location
      t.boolean :is_accessible

      t.timestamps
    end
  end
end
