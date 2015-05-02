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

ActiveRecord::Schema.define(version: 20150119091453) do

  create_table "comments", force: :cascade do |t|
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

  create_table "courses", force: :cascade do |t|
    t.string   "title",                  null: false
    t.string   "category",               null: false
    t.string   "instructor",             null: false
    t.integer  "rank",       default: 0, null: false
    t.boolean  "available",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["category"], name: "index_courses_on_category"
  add_index "courses", ["instructor"], name: "index_courses_on_instructor"
  add_index "courses", ["rank"], name: "index_courses_on_rank"
  add_index "courses", ["title"], name: "index_courses_on_title"

  create_table "entries", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "code",                         null: false
    t.integer  "credit",           default: 0, null: false
    t.string   "department",                   null: false
    t.string   "timetable",                    null: false
    t.boolean  "cross_department",             null: false
    t.boolean  "cross_graduate",               null: false
    t.boolean  "quittable",                    null: false
    t.boolean  "required",                     null: false
    t.text     "note"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "entries", ["code"], name: "index_entries_on_code"
  add_index "entries", ["course_id"], name: "index_entries_on_course_id"
  add_index "entries", ["credit"], name: "index_entries_on_credit"
  add_index "entries", ["cross_department"], name: "index_entries_on_cross_department"
  add_index "entries", ["cross_graduate"], name: "index_entries_on_cross_graduate"
  add_index "entries", ["department"], name: "index_entries_on_department"
  add_index "entries", ["quittable"], name: "index_entries_on_quittable"
  add_index "entries", ["required"], name: "index_entries_on_required"
  add_index "entries", ["timetable"], name: "index_entries_on_timetable"

  create_table "favorite_courses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_entry_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "favorite_courses", ["course_entry_id"], name: "index_favorite_courses_on_course_entry_id"
  add_index "favorite_courses", ["user_id"], name: "index_favorite_courses_on_user_id"

  create_table "terms", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "terms", ["course_id"], name: "index_terms_on_course_id"
  add_index "terms", ["term"], name: "index_terms_on_term"

  create_table "users", force: :cascade do |t|
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

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "user_id"
    t.boolean  "upvote"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "votes", ["votable_id", "votable_type", "user_id"], name: "index_votes_on_votable_id_and_votable_type_and_user_id", unique: true
  add_index "votes", ["votable_id"], name: "index_votes_on_votable_id"

end
