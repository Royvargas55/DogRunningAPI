class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.datetime :reservation_date
      t.string :notes
      t.integer :dog_id

      t.timestamps
    end
  end
end