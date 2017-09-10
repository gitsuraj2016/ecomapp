# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170909105428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "sfirst_name"
    t.string   "bfirst_name"
    t.string   "slast_name"
    t.string   "blast_name"
    t.string   "saddress"
    t.string   "baddress"
    t.string   "scity"
    t.string   "bcity"
    t.string   "sstate"
    t.string   "bstate"
    t.string   "spincode"
    t.string   "bpincode"
    t.string   "sphone"
    t.string   "bphone"
    t.string   "semail"
    t.string   "bemail"
    t.string   "scountry"
    t.string   "bcountry"
    t.boolean  "add_same"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.boolean  "enabled",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image_url"
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.boolean  "enabled",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "order_number"
    t.string   "payment_type"
    t.string   "payment_id"
    t.string   "payment_state"
    t.datetime "payment_date"
    t.string   "shipment_state"
    t.decimal  "shipment_amount", precision: 8, scale: 2
    t.decimal  "discount_amount", precision: 8, scale: 2
    t.decimal  "total_amount",    precision: 8, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.decimal  "amount",       precision: 8, scale: 2
    t.datetime "paid_at"
    t.string   "status"
    t.string   "payment_type"
    t.string   "card_num"
    t.string   "ip_address"
    t.string   "payer_id"
    t.integer  "customer_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "product_brands", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_brands", ["brand_id"], name: "index_product_brands_on_brand_id", using: :btree
  add_index "product_brands", ["product_id"], name: "index_product_brands_on_product_id", using: :btree

  create_table "product_colors", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_colors", ["color_id"], name: "index_product_colors_on_color_id", using: :btree
  add_index "product_colors", ["product_id"], name: "index_product_colors_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image_url"
    t.decimal  "price",          precision: 8, scale: 2
    t.string   "curr_status"
    t.integer  "category_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "subcategory_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["subcategory_id"], name: "index_products_on_subcategory_id", using: :btree

  create_table "subcategories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image_url"
    t.boolean  "active"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "phone"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "product_brands", "brands"
  add_foreign_key "product_brands", "products"
  add_foreign_key "product_colors", "colors"
  add_foreign_key "product_colors", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "subcategories"
  add_foreign_key "subcategories", "categories"
end
