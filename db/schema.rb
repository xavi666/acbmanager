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

ActiveRecord::Schema.define(version: 20160722120525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "position"
    t.string   "position_detail"
    t.integer  "height"
    t.integer  "weithg"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.string   "nacionality"
    t.string   "image"
    t.integer  "price_cents"
    t.string   "href"
    t.integer  "team_id"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "statistics", force: :cascade do |t|
    t.string  "season"
    t.jsonb   "week_1",    default: {}
    t.jsonb   "week_2",    default: {}
    t.jsonb   "week_3",    default: {}
    t.jsonb   "week_4",    default: {}
    t.jsonb   "week_5",    default: {}
    t.jsonb   "week_6",    default: {}
    t.jsonb   "week_7",    default: {}
    t.jsonb   "week_8",    default: {}
    t.jsonb   "week_9",    default: {}
    t.jsonb   "week_10",   default: {}
    t.jsonb   "week_11",   default: {}
    t.jsonb   "week_12",   default: {}
    t.jsonb   "week_13",   default: {}
    t.jsonb   "week_14",   default: {}
    t.jsonb   "week_15",   default: {}
    t.jsonb   "week_16",   default: {}
    t.jsonb   "week_17",   default: {}
    t.jsonb   "week_18",   default: {}
    t.jsonb   "week_19",   default: {}
    t.jsonb   "week_20",   default: {}
    t.jsonb   "week_21",   default: {}
    t.jsonb   "week_22",   default: {}
    t.jsonb   "week_23",   default: {}
    t.jsonb   "week_24",   default: {}
    t.jsonb   "week_25",   default: {}
    t.jsonb   "week_26",   default: {}
    t.jsonb   "week_27",   default: {}
    t.jsonb   "week_28",   default: {}
    t.jsonb   "week_29",   default: {}
    t.jsonb   "week_30",   default: {}
    t.jsonb   "week_31",   default: {}
    t.jsonb   "week_32",   default: {}
    t.jsonb   "week_33",   default: {}
    t.jsonb   "week_34",   default: {}
    t.jsonb   "promedio",  default: {}
    t.jsonb   "total",     default: {}
    t.integer "player_id"
  end

  add_index "statistics", ["player_id"], name: "index_statistics_on_player_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "short_code"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "active",                 default: true
    t.boolean  "super_admin",            default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
