class CreateProductColors < ActiveRecord::Migration
  def change
    create_table :product_colors do |t|
      t.references :product, index: true, foreign_key: true
      t.references :color, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
