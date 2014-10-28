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

ActiveRecord::Schema.define(version: 20141028173612) do

  create_table "comment_votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.boolean  "upvote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_votes", ["comment_id"], name: "index_comment_votes_on_comment_id"
  add_index "comment_votes", ["user_id", "comment_id"], name: "index_comment_votes_on_user_id_and_comment_id", unique: true

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "parent_id"
    t.integer  "rank"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["course_id"], name: "index_comments_on_course_id"
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id"
  add_index "comments", ["rank"], name: "index_comments_on_rank"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "course_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_categories", ["name"], name: "index_course_categories_on_name"

  create_table "course_votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "upvote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_votes", ["course_id"], name: "index_course_votes_on_course_id"
  add_index "course_votes", ["user_id", "course_id"], name: "index_course_votes_on_user_id_and_course_id", unique: true

  create_table "courses", force: true do |t|
    t.string   "name",               default: "", null: false
    t.integer  "course_category_id"
    t.integer  "department_id"
    t.integer  "teacher_id"
    t.integer  "credit",             default: 0,  null: false
    t.string   "code"
    t.integer  "rank",               default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["code"], name: "index_courses_on_code"
  add_index "courses", ["course_category_id"], name: "index_courses_on_course_category_id"
  add_index "courses", ["credit"], name: "index_courses_on_credit"
  add_index "courses", ["department_id"], name: "index_courses_on_department_id"
  add_index "courses", ["name"], name: "index_courses_on_name"
  add_index "courses", ["rank"], name: "index_courses_on_rank"
  add_index "courses", ["teacher_id"], name: "index_courses_on_teacher_id"

  create_table "departments", force: true do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["name"], name: "index_departments_on_name"

  create_table "schedules", force: true do |t|
    t.integer  "course_id"
    t.integer  "day"
    t.integer  "period"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["course_id"], name: "index_schedules_on_course_id"
  add_index "schedules", ["day"], name: "index_schedules_on_day"
  add_index "schedules", ["period"], name: "index_schedules_on_period"

  create_table "teachers", force: true do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["name"], name: "index_teachers_on_name"

  create_table "terms", force: true do |t|
    t.integer  "course_id"
    t.integer  "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "terms", ["course_id"], name: "index_terms_on_course_id"
  add_index "terms", ["term"], name: "index_terms_on_term"

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
