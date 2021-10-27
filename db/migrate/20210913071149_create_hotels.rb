class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :hotel_name
      t.text :hotel_introduction
      t.integer :hotel_price
      t.string :hotel_address
      t.integer :user_id

      t.timestamps
    end
  end
end
