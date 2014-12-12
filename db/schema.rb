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

ActiveRecord::Schema.define(version: 20141210110853) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.integer  "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "repo_id"
    t.string   "commit"
    t.string   "commiter_name"
    t.string   "commit_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commit_message"
  end

  create_table "repos", force: true do |t|
    t.string   "github_repo_name"
    t.string   "github_repo"
    t.integer  "github_repo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_repo_description"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end