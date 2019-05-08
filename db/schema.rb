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

ActiveRecord::Schema.define(version: 2019_05_01_234500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bilges", force: :cascade do |t|
    t.integer "pump_no"
    t.float "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "phone"
    t.string "name"
    t.boolean "bilge_main"
    t.boolean "bilge_backup"
    t.boolean "charge_error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "heartbeats", force: :cascade do |t|
    t.bigint "probe_id"
    t.float "voltage"
    t.float "temp"
    t.float "humid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["probe_id"], name: "index_heartbeats_on_probe_id"
  end

  create_table "light_controllers", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "local_base_url"
    t.string "remote_base_url"
    t.jsonb "power_config"
    t.jsonb "switch_config"
    t.jsonb "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "password"
    t.index ["name", "slug"], name: "index_light_controllers_on_name_and_slug", unique: true
  end

  create_table "probes", force: :cascade do |t|
    t.string "name"
    t.string "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "password"
    t.boolean "hmac"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "heartbeats", "probes"
end
