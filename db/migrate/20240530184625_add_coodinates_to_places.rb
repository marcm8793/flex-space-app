class AddCoodinatesToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :latitude, :float
    add_column :places, :longitude, :float
  end
end
