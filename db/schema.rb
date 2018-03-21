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

ActiveRecord::Schema.define(version: 20180321123725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.bigint "first_team_id"
    t.bigint "second_team_id"
    t.string "type"
    t.integer "position"
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_team_id"], name: "index_matches_on_first_team_id"
    t.index ["second_team_id"], name: "index_matches_on_second_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "first_member_id"
    t.bigint "second_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_member_id"], name: "index_teams_on_first_member_id"
    t.index ["second_member_id"], name: "index_teams_on_second_member_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.integer "number_of_rounds"
    t.string "aasm_state"
    t.bigint "vote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vote_id"], name: "index_tournaments_on_vote_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vote_items", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "vote_user_id"
    t.decimal "vote", precision: 8, scale: 2
    t.bigint "vote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vote_items_on_user_id"
    t.index ["vote_id"], name: "index_vote_items_on_vote_id"
    t.index ["vote_user_id"], name: "index_vote_items_on_vote_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tournaments", "votes"
  add_foreign_key "vote_items", "users"
  add_foreign_key "vote_items", "votes"
end
