class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :start
      t.datetime :end
      t.integer :attendees
      t.string :subject
      t.string :reservation_code
      t.string :email
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
