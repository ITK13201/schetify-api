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

ActiveRecord::Schema[7.0].define(version: 2022_09_07_194633) do
  create_table "attend_statuses", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "user_id", limit: 36, null: false
    t.bigint "schedule_candidate_id", null: false
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_candidate_id"], name: "fk_rails_60d54bba87"
    t.index ["user_id"], name: "fk_rails_1cb3372865"
  end

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
    t.integer "cost"
    t.string "questionnaire_url"
    t.integer "pattern"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost_type", default: 0, null: false
    t.text "description"
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  create_table "notifications", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "title", null: false
    t.string "contents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "fk_rails_78f4b5a537"
  end

  create_table "schedule_candidates", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "fk_rails_8bee898721"
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

  create_table "users_events", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "user_id", limit: 36, null: false
    t.bigint "event_id", null: false
    t.integer "label", null: false
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "fk_rails_973e1aefd3"
    t.index ["user_id"], name: "fk_rails_3fe6b760ff"
  end

  add_foreign_key "attend_statuses", "schedule_candidates", on_delete: :cascade
  add_foreign_key "attend_statuses", "users", on_delete: :cascade
  add_foreign_key "notifications", "events", on_delete: :cascade
  add_foreign_key "schedule_candidates", "events", on_delete: :cascade
  add_foreign_key "users_events", "events", on_delete: :cascade
  add_foreign_key "users_events", "users", on_delete: :cascade
end
