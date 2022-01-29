# frozen_string_literal: true

class AddPhotoReferenceToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :photo_reference, :string
  end
end
