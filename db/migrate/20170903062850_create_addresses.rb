class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :sfirst_name
      t.string :bfirst_name
      t.string :slast_name
      t.string :blast_name
      t.string :saddress
      t.string :baddress
      t.string :scity
      t.string :bcity
      t.string :sstate
      t.string :bstate
      t.string :spincode
      t.string :bpincode
      t.string :sphone
      t.string :bphone
      t.string :semail
      t.string :bemail
      t.string :scountry
      t.string :bcountry
      t.boolean :add_same
      t.timestamps null: false
    end
  end
end
