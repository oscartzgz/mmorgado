# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_10_233436) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.decimal "positive_balance", precision: 10, scale: 2, default: "0.0"
    t.string "code", null: false
    t.index ["code"], name: "index_clients_on_code"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "price_formulas", force: :cascade do |t|
    t.boolean "enable", default: true
    t.string "formula"
    t.string "priceable_type"
    t.bigint "priceable_id"
    t.bigint "provider_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: "", null: false
    t.index ["priceable_type", "priceable_id"], name: "index_price_formulas_on_priceable_type_and_priceable_id"
    t.index ["provider_id"], name: "index_price_formulas_on_provider_id"
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
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.decimal "pp_price", precision: 10, scale: 2, default: "0.0"
    t.decimal "cash_price", precision: 10, scale: 2, default: "0.0"
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
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "code", null: false
    t.string "kind"
    t.string "email"
    t.index ["code"], name: "index_providers_on_code"
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
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "products", "product_brands"
  add_foreign_key "products", "product_categories"
  add_foreign_key "products", "providers"
  add_foreign_key "profiles", "users"
end
