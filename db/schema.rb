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

ActiveRecord::Schema[8.1].define(version: 2026_04_09_072208) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "book_lists", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.bigint "klub_id", null: false
    t.integer "month"
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["book_id"], name: "index_book_lists_on_book_id"
    t.index ["klub_id", "month", "year"], name: "index_book_lists_on_klub_id_and_month_and_year", unique: true
    t.index ["klub_id"], name: "index_book_lists_on_klub_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "author"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "goodreads_url"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "klubs", force: :cascade do |t|
    t.string "activity_type"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "klub_id", null: false
    t.string "role"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["klub_id"], name: "index_memberships_on_klub_id"
    t.index ["user_id", "klub_id"], name: "index_memberships_on_user_id_and_klub_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "book_list_id", null: false
    t.datetime "created_at", null: false
    t.integer "score"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["book_list_id", "user_id"], name: "index_ratings_on_book_list_id_and_user_id", unique: true
    t.index ["book_list_id"], name: "index_ratings_on_book_list_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.string "role", default: "member", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "book_lists", "books"
  add_foreign_key "book_lists", "klubs"
  add_foreign_key "memberships", "klubs"
  add_foreign_key "memberships", "users"
  add_foreign_key "ratings", "book_lists"
  add_foreign_key "ratings", "users"
  add_foreign_key "sessions", "users"
end
