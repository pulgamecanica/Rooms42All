class AddFinishedToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :finished, :boolean, default: false
  end
end
