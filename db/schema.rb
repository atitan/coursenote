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

ActiveRecord::Schema.define(version: 20160302102611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.integer "parent_id"
    t.integer "score", default: 0, null: false
    t.integer "votes_count", default: 0, null: false
    t.string "avatar", null: false
    t.text "content", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["course_id"], name: "index_comments_on_course_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["score"], name: "index_comments_on_score"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.string "category", null: false
    t.string "instructor", null: false
    t.integer "score", default: 0, null: false
    t.integer "votes_count", default: 0, null: false
    t.boolean "available", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "engaged", default: false, null: false
    t.index ["available"], name: "index_courses_on_available"
    t.index ["category"], name: "index_courses_on_category"
    t.index ["engaged"], name: "index_courses_on_engaged"
    t.index ["instructor"], name: "index_courses_on_instructor"
    t.index ["score"], name: "index_courses_on_score"
    t.index ["title"], name: "index_courses_on_title"
    t.index ["votes_count"], name: "index_courses_on_votes_count"
  end

  create_table "entries", id: :serial, force: :cascade do |t|
    t.integer "course_id", null: false
    t.string "code", null: false
    t.integer "credit", default: 0, null: false
    t.string "department", null: false
    t.jsonb "timetable", null: false
    t.string "timestring", null: false
    t.boolean "cross_department", null: false
    t.boolean "cross_graduate", null: false
    t.boolean "quittable", null: false
    t.boolean "required", null: false
    t.string "note", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "capacity", default: 0, null: false
    t.index ["code"], name: "index_entries_on_code"
    t.index ["course_id"], name: "index_entries_on_course_id"
    t.index ["cross_department"], name: "index_entries_on_cross_department"
    t.index ["department"], name: "index_entries_on_department"
    t.index ["timetable"], name: "index_entries_on_timetable", using: :gin
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.jsonb "time_filter", default: {}, null: false
    t.string "passed_courses", default: [], null: false, array: true
    t.string "favorite_courses", default: [], null: false, array: true
    t.boolean "is_student", null: false
    t.string "student_id"
    t.string "secure_random", null: false
    t.datetime "banned_until"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["secure_random"], name: "index_users_on_secure_random", unique: true
    t.index ["student_id"], name: "index_users_on_student_id", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.integer "parent_id"
    t.index ["course_id"], name: "index_versions_on_course_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["parent_id"], name: "index_versions_on_parent_id"
    t.index ["user_id"], name: "index_versions_on_user_id"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "votable_id", null: false
    t.string "votable_type", null: false
    t.integer "user_id", null: false
    t.boolean "upvote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "user_id"], name: "index_votes_on_votable_id_and_votable_type_and_user_id", unique: true
    t.index ["votable_id"], name: "index_votes_on_votable_id"
  end

end
