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

ActiveRecord::Schema.define(version: 20141214054743) do

  create_table "components", force: true do |t|
    t.string   "component_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "syllabus_id"
    t.integer  "order"
  end

  create_table "plaintexts", force: true do |t|
    t.string   "title"
    t.text     "contents",     limit: 255
    t.string   "component_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "syllabus_id"
    t.string   "class_year"
  end

  create_table "syllabuses", force: true do |t|
    t.string   "title"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "course_num"
    t.string   "department"
    t.string   "term"
    t.string   "section_num"
    t.string   "course_type"
    t.integer  "user_id"
    t.text     "header_options"
    t.text     "office_hrs"
  end

  create_table "tables", force: true do |t|
    t.integer  "component_id"
    t.text     "contents"
    t.integer  "rows"
    t.integer  "columns"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "border_class"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "last_name"
    t.string   "first_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "office"
    t.string   "school"
    t.string   "password_digest"
    t.string   "phone"
  end

end
