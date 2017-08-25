class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :order_number
      t.string :payment_type
      t.string :payment_id
      t.string :payment_state
      t.datetime :payment_date
      t.string :shipment_state
      t.decimal :shipment_amount, precision: 8, scale: 2
      t.decimal :discount_amount, precision: 8, scale: 2
      t.decimal :total_amount, precision: 8, scale: 2
      t.timestamps null: false
    end
  end
end
