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

ActiveRecord::Schema[7.0].define(version: 2022_09_05_165454) do
  create_table "events", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "image_url"
    t.string "location_name"
    t.string "location_address"
    t.float "location_latitude"
    t.float "location_longitude"
    t.integer "group_num"
    t.integer "total_cost"
    t.string "questionnaire_url"
    t.integer "pattern"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  create_table "users", id: { type: :string, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "email"
    t.string "firebase_id", null: false
    t.string "twitter_id"
    t.string "google_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["firebase_id"], name: "index_users_on_firebase_id", unique: true
    t.index ["google_id"], name: "index_users_on_google_id", unique: true
    t.index ["twitter_id"], name: "index_users_on_twitter_id", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
