# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_12_133433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "first_surname"
    t.string "second_surname"
    t.string "address"
    t.string "location"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.string "email"
    t.string "mobile_number"
    t.string "phone_number"
    t.string "endorsement_full_name"
    t.string "endorsement_mobile_phone"
    t.string "endorsement_phone_number"
    t.string "endorsement_address"
    t.string "endorsement_location"
    t.string "endorsement_country"
    t.string "endorsement_postal_code"
    t.string "endorsement_relationship"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_brands", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "model"
    t.text "description"
    t.decimal "list_price", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "stock", default: 0, null: false
    t.integer "min_stock", null: false
    t.decimal "credit_price", precision: 10, scale: 2, default: "0.0"
    t.decimal "cost_price", precision: 10, scale: 2, default: "0.0"
    t.bigint "provider_id", null: false
    t.bigint "product_brand_id", null: false
    t.bigint "product_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_brand_id"], name: "index_products_on_product_brand_id"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
    t.index ["provider_id"], name: "index_products_on_provider_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "first_surname"
    t.string "second_surname"
    t.string "postal_code"
    t.string "state"
    t.string "location"
    t.string "mobile_number"
    t.string "suburb"
    t.string "street"
    t.string "ext_num"
    t.string "int_num"
    t.string "phone_number"
    t.string "photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "full_name"
    t.string "phone_number"
    t.string "address"
    t.string "city"
    t.string "country"
    t.string "postal_code"
    t.string "contact_full_name"
    t.string "contact_email"
    t.string "contact_phone_number"
    t.string "contact_mobile_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "products", "product_brands"
  add_foreign_key "products", "product_categories"
  add_foreign_key "products", "providers"
  add_foreign_key "profiles", "users"
end
