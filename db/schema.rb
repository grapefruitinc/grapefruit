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

ActiveRecord::Schema.define(version: 20140321042449) do

  create_table "capsules", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
  end

  create_table "course_users", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "subject"
    t.string   "course_number"
    t.string   "course_registration_number"
    t.string   "semester"
    t.integer  "year"
    t.integer  "spots_available"
    t.integer  "credits"
    t.string   "slug"
  end

  add_index "courses", ["slug"], name: "index_courses_on_slug", using: :btree

  create_table "documents", force: true do |t|
    t.string   "file"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.integer  "capsule_id"
    t.integer  "lecture_id"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "lectures", force: true do |t|
    t.string   "name"
    t.integer  "lecture_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "capsule_id"
    t.string   "mediasite_url"
  end

  create_table "problem_sets", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "capsule_id"
  end

  create_table "problems", force: true do |t|
    t.integer  "problem_set_id"
    t.text     "question"
    t.text     "solution"
    t.integer  "worth",          default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", force: true do |t|
    t.integer  "course_id"
    t.integer  "topic_id"
    t.integer  "author_id"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.integer  "replies",        default: 0
    t.integer  "course_id"
    t.integer  "author_id"
    t.integer  "last_poster_id"
    t.string   "name"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "capsule_id"
    t.integer  "last_post_id"
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
    t.boolean  "is_admin"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "video_texts", force: true do |t|
    t.text     "content"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "video_id"
  end

  create_table "videos", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "lecture_id"
    t.string   "file"
    t.string   "youtube_id"
  end

end
