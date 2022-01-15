class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :sauna, null: false
      t.references :jiro, null: false

      t.timestamps
    end
  end
end
