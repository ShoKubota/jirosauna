class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.integer :longitude, null: false
      t.integer :latitude, null: false
      t.integer :rating
      t.string :opening_hours
      t.integer :tel_number
      t.string :place_id, null: false

      t.timestamps
    end
  end
end
