class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.boolean :active,:default => true

      t.timestamps null: false
    end
  end
end
