class AddColumnsToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :client_num, :integer
    add_column :bookings, :using_days, :integer
  end
end
