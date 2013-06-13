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

ActiveRecord::Schema.define(:version => 20130613005702) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "followed_users", :force => true do |t|
    t.string   "login"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "avatar_url"
    t.string   "gravatar_id"
  end

  create_table "followed_users_users", :id => false, :force => true do |t|
    t.integer "user_id",          :null => false
    t.integer "followed_user_id", :null => false
  end

  add_index "followed_users_users", ["user_id", "followed_user_id"], :name => "index_users_followed_users_on_user_id_and_followed_user_id", :unique => true

  create_table "recommendations", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "score"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "rec_type"
    t.text     "description"
  end

  create_table "starred_repos", :force => true do |t|
    t.integer  "github_id"
    t.string   "owner_login"
    t.integer  "owner_github_id"
    t.string   "owner_avatar_url"
    t.string   "owner_gravatar_id"
    t.string   "owner_url"
    t.string   "name"
    t.string   "full_name"
    t.text     "description"
    t.boolean  "private"
    t.boolean  "fork"
    t.string   "url"
    t.string   "html_url"
    t.string   "clone_url"
    t.string   "git_url"
    t.string   "ssh_url"
    t.string   "svn_url"
    t.string   "mirror_url"
    t.string   "homepage"
    t.string   "language"
    t.integer  "forks"
    t.integer  "forks_count"
    t.integer  "watchers"
    t.integer  "watchers_count"
    t.integer  "size"
    t.string   "master_branch"
    t.integer  "open_issues"
    t.string   "pushed_at"
    t.string   "github_created_at"
    t.string   "github_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "starred_repos", ["full_name"], :name => "index_starred_repos_on_full_name"

  create_table "starred_repos_users", :id => false, :force => true do |t|
    t.integer "user_id",         :null => false
    t.integer "starred_repo_id", :null => false
  end

  add_index "starred_repos_users", ["starred_repo_id", "user_id"], :name => "index_starred_repos_users_on_starred_repo_id_and_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
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
    t.text     "bio"
    t.integer  "public_repos"
    t.integer  "public_gists"
    t.integer  "followers"
    t.integer  "following"
    t.string   "html_url"
    t.string   "github_profile_created_at"
    t.string   "type"
    t.string   "slug"
    t.string   "followers_url"
    t.string   "following_url"
    t.string   "starred_url"
    t.string   "subscriptions_url"
    t.string   "organizations_url"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug"

end
