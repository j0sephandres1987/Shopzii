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

ActiveRecord::Schema.define(version: 20150923164552) do

  create_table "cart_items", force: true do |t|
    t.integer  "product_id", default: 0
    t.integer  "order_id",   default: 0
    t.integer  "quantity",   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["order_id"], name: "index_cart_items_on_order_id"
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id"

  create_table "cart_items_values", id: false, force: true do |t|
    t.integer "value_id"
    t.integer "cart_item_id", default: 0
  end

  add_index "cart_items_values", ["cart_item_id"], name: "index_cart_items_values_on_cart_item_id"
  add_index "cart_items_values", ["value_id"], name: "index_cart_items_values_on_value_id"

  create_table "categories", force: true do |t|
    t.string   "name",          limit: 50,                null: false
    t.integer  "collection_id",            default: 0
    t.integer  "store_id",                 default: 0
    t.boolean  "status",                   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["collection_id"], name: "index_categories_on_collection_id"
  add_index "categories", ["store_id"], name: "index_categories_on_store_id"

  create_table "collections", force: true do |t|
    t.string   "name",       limit: 50,                null: false
    t.integer  "store_id",              default: 0
    t.boolean  "status",                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["store_id"], name: "index_collections_on_store_id"

  create_table "orders", force: true do |t|
    t.integer  "store_id",   default: 0
    t.boolean  "status",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["store_id"], name: "index_orders_on_store_id"

  create_table "photos", force: true do |t|
    t.integer  "product_id",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "photos", ["product_id"], name: "index_photos_on_product_id"

  create_table "products", force: true do |t|
    t.string   "name",           limit: 50,                null: false
    t.integer  "price",                     default: 0
    t.text     "description"
    t.integer  "collection_id",             default: 0
    t.integer  "category_id",               default: 0
    t.integer  "subcategory_id",            default: 0
    t.integer  "store_id",                  default: 0
    t.boolean  "status",                    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock",                     default: 0
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"
  add_index "products", ["collection_id"], name: "index_products_on_collection_id"
  add_index "products", ["store_id"], name: "index_products_on_store_id"
  add_index "products", ["subcategory_id"], name: "index_products_on_subcategory_id"

  create_table "products_shipment_methods", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "shipment_method_id"
  end

  add_index "products_shipment_methods", ["product_id"], name: "index_products_shipment_methods_on_product_id"
  add_index "products_shipment_methods", ["shipment_method_id"], name: "index_products_shipment_methods_on_shipment_method_id"

  create_table "properties", force: true do |t|
    t.string   "name",         limit: 50,             null: false
    t.integer  "product_id",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_mode",            default: 0
  end

  add_index "properties", ["product_id"], name: "index_properties_on_product_id"

  create_table "shipment_methods", force: true do |t|
    t.string   "name",          limit: 50,                 null: false
    t.string   "delivery_time"
    t.integer  "price",                    default: 0
    t.integer  "store_id",                 default: 0
    t.boolean  "free",                     default: false
    t.boolean  "status",                   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipment_methods", ["store_id"], name: "index_shipment_methods_on_store_id"

  create_table "stores", force: true do |t|
    t.string   "name",                      null: false
    t.integer  "user_id",    default: 0
    t.boolean  "status",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stores", ["user_id"], name: "index_stores_on_user_id"

  create_table "subcategories", force: true do |t|
    t.string   "name",        limit: 50,                null: false
    t.integer  "category_id",            default: 0
    t.integer  "store_id",               default: 0
    t.boolean  "status",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id"
  add_index "subcategories", ["store_id"], name: "index_subcategories_on_store_id"

  create_table "users", force: true do |t|
    t.string   "full_name"
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  create_table "values", force: true do |t|
    t.string   "name",        limit: 50,             null: false
    t.integer  "property_id",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "values", ["property_id"], name: "index_values_on_property_id"

end
