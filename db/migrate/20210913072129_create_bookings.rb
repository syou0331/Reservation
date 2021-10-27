class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.integer :total_price
      t.date :check_in
      t.date :check_out
      t.integer :hotel_id

      t.timestamps

    end
  end
end
