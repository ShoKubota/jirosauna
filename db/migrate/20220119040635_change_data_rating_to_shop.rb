class ChangeDataRatingToShop < ActiveRecord::Migration[6.1]
  def change
    change_column :shops, :rating, :float
  end
end
