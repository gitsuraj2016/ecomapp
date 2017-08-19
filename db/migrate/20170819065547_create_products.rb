class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 8, scale: 2
      t.string :curr_status
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
