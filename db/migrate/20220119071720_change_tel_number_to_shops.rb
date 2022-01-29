# frozen_string_literal: true

class ChangeTelNumberToShops < ActiveRecord::Migration[6.1]
  def change
    change_column :shops, :tel_number, :string
  end
end
