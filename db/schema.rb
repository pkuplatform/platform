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

ActiveRecord::Schema.define(:version => 20111113063738) do

  create_table "activities", :force => true do |t|
    t.integer  "group_id"
    t.string   "title"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "location_id"
    t.boolean  "public"
    t.integer  "status"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["group_id"], :name => "index_activities_on_group_id"
  add_index "activities", ["location_id"], :name => "index_activities_on_location_id"

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["imageable_id", "imageable_type"], :name => "index_albums_on_imageable_id_and_imageable_type"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "groups", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "slogan"
    t.text     "description"
    t.text     "history"
    t.text     "organization"
    t.string   "email"
    t.integer  "status"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["category_id"], :name => "index_groups_on_category_id"

  create_table "message_copies", :force => true do |t|
    t.integer  "sent_messageable_id"
    t.string   "sent_messageable_type"
    t.integer  "recipient_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_copies", ["sent_messageable_id", "recipient_id"], :name => "outbox_idx"

  create_table "messages", :force => true do |t|
    t.integer  "received_messageable_id"
    t.string   "received_messageable_type"
    t.integer  "sender_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "opened",                    :default => false
    t.boolean  "deleted",                   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["received_messageable_id", "sender_id"], :name => "inbox_idx"

  create_table "pictures", :force => true do |t|
    t.integer  "album_id"
    t.integer  "user_id"
    t.string   "remark"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["album_id"], :name => "index_pictures_on_album_id"
  add_index "pictures", ["user_id"], :name => "index_pictures_on_user_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "status"
    t.string   "name"
    t.string   "nickname"
    t.integer  "gender"
    t.string   "student_id"
    t.string   "phone"
    t.integer  "points"
    t.text     "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.integer  "tagable_id"
    t.string   "tagable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tagable_id", "tagable_type"], :name => "index_tags_on_tagable_id_and_tagable_type"

  create_table "user_activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_activities", ["activity_id"], :name => "index_user_activities_on_activity_id"
  add_index "user_activities", ["user_id"], :name => "index_user_activities_on_user_id"

  create_table "user_groups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_groups", ["group_id"], :name => "index_user_groups_on_group_id"
  add_index "user_groups", ["user_id"], :name => "index_user_groups_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
