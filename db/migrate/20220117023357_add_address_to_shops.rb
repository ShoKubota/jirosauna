class AddAddressToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :address, :string
  end
end
