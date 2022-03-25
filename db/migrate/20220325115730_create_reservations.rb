class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :room, null: false, foreign_key: true
      t.datetime :t_beginning
      t.datetime :t_ending
      t.integer :attendees
      t.string :subject
      t.string :reservation_code
      t.string :email

      t.timestamps
    end
  end
end
