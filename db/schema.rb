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

ActiveRecord::Schema.define(version: 20160125041409) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "announcements", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "course_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignment_types", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.float    "default_point_value", limit: 24
    t.boolean  "drops_lowest",        limit: 1
    t.float    "percentage",          limit: 24
    t.integer  "course_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "description",        limit: 65535
    t.float    "points",             limit: 24
    t.integer  "course_id",          limit: 4
    t.integer  "assignment_type_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "reveal_day"
    t.date     "due_day"
  end

  create_table "capsules", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id",   limit: 4
    t.text     "description", limit: 65535
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "lecture_id", limit: 4
    t.integer  "author_id",  limit: 4
    t.string   "body",       limit: 700
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_users", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",       limit: 255
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.integer  "instructor_id",              limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",                limit: 65535
    t.string   "subject",                    limit: 255
    t.string   "course_number",              limit: 255
    t.string   "course_registration_number", limit: 255
    t.string   "semester",                   limit: 255
    t.integer  "year",                       limit: 4
    t.integer  "spots_available",            limit: 4
    t.integer  "credits",                    limit: 4
    t.string   "slug",                       limit: 255
    t.text     "problem_set_url",            limit: 65535
    t.integer  "school_account_id",          limit: 4
    t.string   "instructor_label",           limit: 255
  end

  add_index "courses", ["school_account_id"], name: "index_courses_on_school_account_id", using: :btree
  add_index "courses", ["slug"], name: "index_courses_on_slug", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "file",          limit: 255
    t.text     "description",   limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id",     limit: 4
    t.integer  "capsule_id",    limit: 4
    t.integer  "lecture_id",    limit: 4
    t.integer  "assignment_id", limit: 4
    t.integer  "submission_id", limit: 4
    t.integer  "grade_id",      limit: 4
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "grades", force: :cascade do |t|
    t.float    "points",        limit: 24
    t.text     "comments",      limit: 65535
    t.integer  "assignment_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lectures", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "lecture_number", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "capsule_id",     limit: 4
    t.text     "description",    limit: 65535
    t.boolean  "live",           limit: 1,     default: false
  end

  create_table "problem_sets", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "capsule_id", limit: 4
  end

  create_table "replies", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.integer  "topic_id",   limit: 4
    t.integer  "author_id",  limit: 4
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_accounts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.string   "short_name", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.text     "comments",      limit: 65535
    t.integer  "user_id",       limit: 4
    t.integer  "assignment_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "replies",        limit: 4,     default: 0
    t.integer  "course_id",      limit: 4
    t.integer  "author_id",      limit: 4
    t.integer  "last_poster_id", limit: 4
    t.string   "name",           limit: 255
    t.text     "body",           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "capsule_id",     limit: 4
    t.integer  "last_post_id",   limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.boolean  "can_create_courses",     limit: 1,   default: false
    t.integer  "school_account_id",      limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["school_account_id"], name: "index_users_on_school_account_id", using: :btree

  create_table "video_texts", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.string   "time",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "video_id",   limit: 4
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",   limit: 65535
    t.integer  "lecture_id",    limit: 4
    t.string   "file",          limit: 255
    t.string   "youtube_id",    limit: 255
    t.string   "mediasite_url", limit: 500
  end

end
