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

ActiveRecord::Schema.define(version: 20171104095425) do

  create_table "action_requests", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "host_id", null: false
    t.string "request", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hosts", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "domain", null: false
    t.string "name", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain"], name: "index_hosts_on_domain", unique: true
  end

  create_table "passwords", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "user_id", null: false
    t.string "app", null: false
    t.string "cipher", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app"], name: "index_passwords_on_app"
    t.index ["user_id", "app"], name: "index_passwords_on_user_id_and_app", unique: true
  end

  create_table "sessions", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "user_id", null: false
    t.string "code", null: false
    t.string "app", null: false
    t.datetime "expiry_time", null: false
    t.string "ip"
    t.boolean "revoked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app"], name: "index_sessions_on_app"
    t.index ["code"], name: "index_sessions_on_code"
    t.index ["user_id", "code"], name: "index_sessions_on_user_id_and_code", unique: true
  end

  create_table "users", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone"
    t.boolean "is_internal", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "dimensions", limit: 4294967295
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
