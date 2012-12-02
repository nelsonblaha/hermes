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

ActiveRecord::Schema.define(:version => 20121202025930) do

  create_table "inboxes", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "messages_expire"
    t.integer  "message_expiration_seconds"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "traits_hash"
    t.integer  "message_source_id"
    t.string   "message_source_type"
    t.boolean  "read"
    t.boolean  "dismissed"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "unique_identifier"
  end

  create_table "presentations", :force => true do |t|
    t.integer  "inbox_id"
    t.integer  "message_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rss_feeds", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rules", :force => true do |t|
    t.integer  "rule_owner_id"
    t.string   "rule_owner_type"
    t.string   "name"
    t.integer  "mode"
    t.string   "limit"
    t.integer  "meta_rule_id"
    t.boolean  "meta_or_mode"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "logic"
  end

  create_table "traits", :force => true do |t|
    t.integer  "traited_id"
    t.string   "traited_type"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
