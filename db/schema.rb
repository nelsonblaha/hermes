ActiveRecord::Schema.define(:version => 20130221014841) do


  create_table "inboxes", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "messages_expire"
    t.integer  "message_expiration_seconds"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "template"
  end

  create_table "messages", :force => true do |t|
    t.text     "traits_hash"
    t.integer  "message_source_id"
    t.string   "message_source_type"
    t.boolean  "read"
    t.boolean  "resolved"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "unique_identifier"
  end

  create_table "presentations", :force => true do |t|
    t.integer  "inbox_id"
    t.integer  "message_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "rule_id"
  end

  create_table "rss_feeds", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rules", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "user_id"
    t.integer  "parent_rule_id"
    t.integer  "passing_children_needed_to_pass"
    t.integer  "passing_traits_needed_to_pass"
  end

  create_table "traits", :force => true do |t|
    t.integer  "traited_id"
    t.string   "traited_type"
    t.string   "name"
    t.text     "value",        :limit => 255
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "mode",                        :default => 1
  end

  create_table "twitters", :force => true do |t|
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.boolean  "authorized"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
