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

ActiveRecord::Schema.define(:version => 20120225172254) do

  create_table "activities", :force => true do |t|
    t.integer  "group_id"
    t.string   "title"
    t.string   "pyname"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "location",            :default => ""
    t.boolean  "public",              :default => true
    t.integer  "status",              :default => 1
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.integer  "points",              :default => 0
    t.boolean  "delta",               :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["group_id"], :name => "index_activities_on_group_id"

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["imageable_id", "imageable_type"], :name => "index_albums_on_imageable_id_and_imageable_type"

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogs", ["activity_id", "author_id"], :name => "index_blogs_on_activity_id_and_author_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "circles", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "status",     :default => 0
    t.integer  "mode",       :default => 480
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

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

  create_table "dialogs", :force => true do |t|
    t.integer  "channel_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dialogs", ["channel_id"], :name => "index_dialogs_on_channel_id"
  add_index "dialogs", ["user_id"], :name => "index_dialogs_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "subject_type"
    t.integer  "subject_id"
    t.string   "action"
    t.string   "object_type"
    t.integer  "object_id"
    t.boolean  "processed",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.string   "contact"
    t.string   "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["user_id"], :name => "index_feedbacks_on_user_id"

  create_table "form_second_building_applications", :force => true do |t|
    t.string   "zhubandanwei"
    t.string   "fuzeren"
    t.string   "xingming"
    t.string   "yuanxi"
    t.string   "lianxifangshi"
    t.string   "zhujiangren"
    t.string   "gongzuodanwei"
    t.string   "zhicheng"
    t.string   "yanjiangtimu"
    t.string   "fangyingneirong"
    t.string   "huodongxingshi"
    t.date     "huodongshijian"
    t.integer  "startclass"
    t.integer  "endclass"
    t.integer  "huodongrenshu"
    t.string   "zhidaozhongxin"
    t.string   "jiaowuzhang"
    t.string   "classroom"
    t.string   "beizhu"
    t.integer  "status"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "form_second_building_applications", ["group_id"], :name => "index_form_second_building_applications_on_group_id"

  create_table "groups", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "pyname"
    t.string   "slogan",            :default => ""
    t.text     "introduction"
    t.text     "description"
    t.text     "history"
    t.text     "organization"
    t.string   "email",             :default => ""
    t.date     "founded_at"
    t.integer  "status",            :default => 4
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "points",            :default => 0
    t.boolean  "delta",             :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["category_id"], :name => "index_groups_on_category_id"

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

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

  create_table "newsfeeds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "times",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "newsfeeds", ["event_id"], :name => "index_newsfeeds_on_event_id"
  add_index "newsfeeds", ["user_id"], :name => "index_newsfeeds_on_user_id"

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
    t.integer  "status",               :default => 4
    t.string   "name"
    t.integer  "unread_message_count"
    t.string   "pyname"
    t.string   "nickname"
    t.integer  "gender",               :default => 1
    t.string   "student_id"
    t.string   "phone"
    t.integer  "points",               :default => 0
    t.text     "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "delta",                :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "sms", :force => true do |t|
    t.integer  "group_id"
    t.text     "content"
    t.integer  "status",     :default => -1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sms", ["group_id"], :name => "index_sms_on_group_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_circles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "circle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_circles", ["circle_id"], :name => "index_user_circles_on_circle_id"
  add_index "user_circles", ["user_id"], :name => "index_user_circles_on_user_id"

  create_table "user_recommends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recommendable_id"
    t.string   "recommendable_type"
    t.float    "value",              :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_recommends", ["recommendable_id", "recommendable_type"], :name => "index_user_recommends_on_recommendable_id_and_recommendable_type"
  add_index "user_recommends", ["user_id"], :name => "index_user_recommends_on_user_id"

  create_table "users", :force => true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
