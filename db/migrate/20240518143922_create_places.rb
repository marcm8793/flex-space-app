class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :address_country
      t.string :address_city
      t.string :address_street_name
      t.integer :address_zip_code
      t.integer :screen_number
      t.integer :desk_number
      t.integer :bed_number
      t.float :internet_speed
      t.boolean :outdoor
      t.boolean :air_conditionning
      t.float :price_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
