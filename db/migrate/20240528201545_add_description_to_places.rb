class AddDescriptionToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :description, :text
  end
end
