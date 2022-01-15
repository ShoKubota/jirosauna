class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :crypted_password
      t.string :salt
      t.integer :role, default: 0
      t.string :avatar

      t.timestamps
    end
  end
end
