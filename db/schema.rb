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

ActiveRecord::Schema.define(version: 20180402105857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.bigint "first_team_id"
    t.bigint "second_team_id"
    t.integer "match_type", default: 1
    t.integer "position"
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id"
    t.integer "first_team_result"
    t.integer "second_team_result"
    t.index ["first_team_id"], name: "index_matches_on_first_team_id"
    t.index ["second_team_id"], name: "index_matches_on_second_team_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "tournament_id"
    t.bigint "user_id"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_ratings_on_tournament_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "score", default: 3
    t.bigint "team_id"
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_scores_on_match_id"
    t.index ["team_id"], name: "index_scores_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "first_member_id"
    t.bigint "second_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id"
    t.index ["first_member_id"], name: "index_teams_on_first_member_id"
    t.index ["second_member_id"], name: "index_teams_on_second_member_id"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.integer "number_of_rounds"
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournaments_users", id: false, force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.bigint "user_id", null: false
    t.index ["tournament_id", "user_id"], name: "index_tournaments_users_on_tournament_id_and_user_id"
    t.index ["user_id", "tournament_id"], name: "index_tournaments_users_on_user_id_and_tournament_id"
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
    t.integer "value"
    t.bigint "vote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vote_items_on_user_id"
    t.index ["vote_id"], name: "index_vote_items_on_vote_id"
    t.index ["vote_user_id"], name: "index_vote_items_on_vote_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "tournament_id"
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_votes_on_tournament_id"
  end

  add_foreign_key "matches", "tournaments"
  add_foreign_key "ratings", "tournaments"
  add_foreign_key "ratings", "users"
  add_foreign_key "scores", "matches"
  add_foreign_key "scores", "teams"
  add_foreign_key "teams", "tournaments"
  add_foreign_key "vote_items", "users"
  add_foreign_key "vote_items", "votes"
  add_foreign_key "votes", "tournaments"
end
