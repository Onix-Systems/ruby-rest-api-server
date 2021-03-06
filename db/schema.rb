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

ActiveRecord::Schema.define(version: 20160314090641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_products", force: :cascade do |t|
    t.integer "client_id"
    t.integer "product_id"
  end

  add_index "client_products", ["client_id"], name: "index_client_products_on_client_id", using: :btree
  add_index "client_products", ["product_id"], name: "index_client_products_on_product_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.integer  "client_type",           null: false
    t.integer  "gln",         limit: 8, null: false
    t.string   "full_name",             null: false
    t.string   "short_name",            null: false
    t.text     "description"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "clients", ["full_name"], name: "index_clients_on_full_name", unique: true, using: :btree
  add_index "clients", ["gln"], name: "index_clients_on_gln", unique: true, using: :btree
  add_index "clients", ["short_name"], name: "index_clients_on_short_name", unique: true, using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "gtin",                   limit: 8,                null: false
    t.string   "bar_code_type",                                   null: false
    t.string   "unit_descriptor",                                 null: false
    t.string   "internal_supplier_code",                          null: false
    t.string   "brand_name",                                      null: false
    t.string   "description_short",                               null: false
    t.text     "description_full"
    t.boolean  "active",                           default: true, null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "products", ["active"], name: "index_products_on_active", using: :btree
  add_index "products", ["gtin"], name: "index_products_on_gtin", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
