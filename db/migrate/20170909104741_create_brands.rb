class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.boolean :enabled, :default => true

      t.timestamps null: false
    end
    brands = ["Johnson & Johnson", "Bausch & Lomb", "CIBA Vision", "Maxim", "FreshKon", "Aryan", "Bescon", "Magic Colorlens", "Alcon", "Other"]
    brands.each {|b| Brand.create(:name => b)}
  end
end
