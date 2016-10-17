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

ActiveRecord::Schema.define(version: 20161015231400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "gyms", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "open_time"
    t.string   "close_time"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_gyms_on_user_id", using: :btree
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "tokenizable_type", null: false
    t.integer  "tokenizable_id",   null: false
    t.string   "token",            null: false
    t.text     "data"
    t.datetime "expires_at"
    t.datetime "created_at",       null: false
    t.index ["expires_at"], name: "index_tokens_on_expires_at", using: :btree
    t.index ["token"], name: "index_tokens_on_token", using: :btree
    t.index ["tokenizable_id", "tokenizable_type", "name"], name: "index_tokens_on_tokenizable_id_and_tokenizable_type_and_name", unique: true, using: :btree
    t.index ["tokenizable_type", "tokenizable_id"], name: "index_tokens_on_tokenizable_type_and_tokenizable_id", using: :btree
  end

  create_table "user_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "gym_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gym_id"], name: "index_user_tokens_on_gym_id", using: :btree
    t.index ["user_id"], name: "index_user_tokens_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.string   "type_user"
    t.boolean  "admin",                  default: false, null: false
    t.string   "work_address"
    t.string   "home_address"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "gyms", "users"
  add_foreign_key "user_tokens", "gyms"
  add_foreign_key "user_tokens", "users"
end
