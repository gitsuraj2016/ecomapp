class CreateProductBrands < ActiveRecord::Migration
  def change
    create_table :product_brands do |t|
      t.references :product, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
