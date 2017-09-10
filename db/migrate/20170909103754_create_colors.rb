class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name
      t.boolean :enabled, :default => true

      t.timestamps null: false
    end

    colors = ["Aqua", "Autumn", "Black", "Blue", "Brown", "Dark" "Blue", "Green", "Gray", "Hazel", "Honey", "Kiwi",
    "Light Blue","Moon Gray", "Moonlight", "Violet", "Yellow", "Turquoise", "Pink", "Accent Style", "Vivid Style",
    "Gemstone Green", "Sterling Gray", "Baby Blue", "Blue","Big Brown","Groovy Green", "Perky Brown", "Baby Aqua","Dark Gray", "Navy Blue",
    "Sky Blue", "Mosaic"
    ]

    colors.each { |color| Color.create(:name => color) }
  end
end
