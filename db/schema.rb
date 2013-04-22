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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130420071347) do

  create_table "followed_users", :force => true do |t|
    t.string   "login"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "login"
    t.integer  "github_id"
    t.string   "avatar_url"
    t.string   "gravatar_id"
    t.string   "url"
    t.string   "company"
    t.string   "blog"
    t.string   "location"
    t.string   "email"
    t.boolean  "hireable"
    t.string   "bio"
    t.integer  "public_repos"
    t.integer  "public_gists"
    t.integer  "followers"
    t.integer  "following"
    t.string   "html_url"
    t.datetime "github_profile_created_at", :limit => 255
    t.string   "type"
  end

  create_table "users_followed_users", :id => false, :force => true do |t|
    t.integer "user_id",          :null => false
    t.integer "followed_user_id", :null => false
  end

  add_index "users_followed_users", ["user_id", "followed_user_id"], :name => "index_users_followed_users_on_user_id_and_followed_user_id", :unique => true

end