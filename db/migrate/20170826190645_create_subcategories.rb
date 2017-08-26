class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.boolean :active
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
