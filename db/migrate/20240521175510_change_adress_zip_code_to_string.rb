class ChangeAdressZipCodeToString < ActiveRecord::Migration[7.1]
  def change
    change_column :places, :address_zip_code, :string
  end
end
