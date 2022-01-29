# frozen_string_literal: true

class ChangeDataLongitudeLatitudeToShops < ActiveRecord::Migration[6.1]
  def change
    change_column :shops, :longitude, :decimal, precision: 10, scale: 7
    change_column :shops, :latitude, :decimal, precision: 10, scale: 7
  end
end
