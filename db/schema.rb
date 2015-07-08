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
    t.integer  "user_id",    limit: 4,                 null: false
    t.integer  "course_id",  limit: 4,                 null: false
    t.integer  "parent_id",  limit: 4
    t.integer  "score",      limit: 4,     default: 0, null: false
    t.text     "content",    limit: 65535,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["course_id"], name: "index_comments_on_course_id", using: :btree
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id", using: :btree
  add_index "comments", ["score"], name: "index_comments_on_score", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title",      limit: 255,                null: false
    t.string   "category",   limit: 255,                null: false
    t.string   "instructor", limit: 255,                null: false
    t.integer  "score",      limit: 4,   default: 0,    null: false
    t.boolean  "available",              default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["available"], name: "index_courses_on_available", using: :btree
  add_index "courses", ["category"], name: "index_courses_on_category", using: :btree
  add_index "courses", ["instructor"], name: "index_courses_on_instructor", using: :btree
  add_index "courses", ["score"], name: "index_courses_on_score", using: :btree
  add_index "courses", ["title"], name: "index_courses_on_title", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "course_id",        limit: 4,                 null: false
    t.string   "code",             limit: 255,               null: false
    t.integer  "credit",           limit: 4,     default: 0, null: false
    t.string   "department",       limit: 255,               null: false
    t.string   "timetable",        limit: 255,               null: false
    t.string   "timestring",       limit: 255,               null: false
    t.boolean  "cross_department",                           null: false
    t.boolean  "cross_graduate",                             null: false
    t.boolean  "quittable",                                  null: false
    t.boolean  "required",                                   null: false
    t.text     "note",             limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "entries", ["code"], name: "index_entries_on_code", using: :btree
  add_index "entries", ["course_id"], name: "index_entries_on_course_id", using: :btree
  add_index "entries", ["credit"], name: "index_entries_on_credit", using: :btree
  add_index "entries", ["cross_department"], name: "index_entries_on_cross_department", using: :btree
  add_index "entries", ["cross_graduate"], name: "index_entries_on_cross_graduate", using: :btree
  add_index "entries", ["department"], name: "index_entries_on_department", using: :btree
  add_index "entries", ["quittable"], name: "index_entries_on_quittable", using: :btree
  add_index "entries", ["required"], name: "index_entries_on_required", using: :btree
  add_index "entries", ["timestring"], name: "index_entries_on_timestring", using: :btree
  add_index "entries", ["timetable"], name: "index_entries_on_timetable", using: :btree

  create_table "favorite_courses", force: :cascade do |t|
    t.integer  "user_id",         limit: 4, null: false
    t.integer  "course_entry_id", limit: 4, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "favorite_courses", ["course_entry_id"], name: "index_favorite_courses_on_course_entry_id", using: :btree
  add_index "favorite_courses", ["user_id"], name: "index_favorite_courses_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "time_filter",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["time_filter"], name: "index_users_on_time_filter", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id",   limit: 4,   null: false
    t.string   "votable_type", limit: 255, null: false
    t.integer  "user_id",      limit: 4,   null: false
    t.boolean  "upvote"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "votes", ["votable_id", "votable_type", "user_id"], name: "index_votes_on_votable_id_and_votable_type_and_user_id", unique: true, using: :btree
  add_index "votes", ["votable_id"], name: "index_votes_on_votable_id", using: :btree

end
