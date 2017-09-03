class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.datetime :paid_at
      t.string :status
      t.string :payment_type
      t.string :card_num
      t.string :ip_address
      t.string :payer_id
      t.integer :customer_id
      t.timestamps null: false
    end
  end
end
