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

ActiveRecord::Schema.define(version: 20141009111111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: true do |t|
    t.string "key"
    t.string "app_name"
    t.string "type"
    t.string "owner"
  end

  create_table "areas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas_regions", force: true do |t|
    t.integer "area_id"
    t.integer "region_id"
  end

  create_table "areas_users", force: true do |t|
    t.integer "area_id"
    t.integer "user_id"
    t.string  "relationship"
  end

  create_table "consumed_foods", force: true do |t|
    t.integer  "interview_id"
    t.string   "n_id"
    t.integer  "servings"
    t.string   "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "entered_food"
  end

  add_index "consumed_foods", ["interview_id"], name: "index_consumed_foods_on_interview_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "title"
    t.datetime "start"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "family_relationships", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "households", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "area_id"
  end

  create_table "interviews", force: true do |t|
    t.integer  "household_id"
    t.string   "roof"
    t.string   "wall"
    t.string   "floor"
    t.string   "bedroom_count"
    t.string   "separate_kitchen"
    t.string   "light"
    t.string   "fuel_type"
    t.string   "water_source"
    t.string   "water_chlorinated"
    t.string   "bathroom"
    t.string   "sewage"
    t.string   "person_count"
    t.string   "total_income"
    t.string   "income_unit"
    t.string   "shoe_cost"
    t.string   "shoe_unit"
    t.string   "medicine_cost"
    t.string   "medicine_unit"
    t.string   "school_cost"
    t.string   "school_unit"
    t.string   "college_cost"
    t.string   "college_unit"
    t.string   "water_electric_cost"
    t.string   "water_electric_unit"
    t.string   "misc_cost"
    t.string   "misc_unit"
    t.string   "radio"
    t.string   "tv"
    t.string   "refrigerator"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.boolean  "seasonal"
    t.string   "description"
    t.integer  "person_id"
    t.integer  "occupation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "given_name"
    t.string   "family_name"
    t.integer  "family_relationship_id"
    t.date     "birthday"
    t.string   "education_level"
    t.string   "gender"
    t.boolean  "in_school"
    t.boolean  "is_alive"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "household_id"
  end

  create_table "permissions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_roles", force: true do |t|
    t.integer "permission_id"
    t.integer "role_id"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "tokens", force: true do |t|
    t.string   "token_string"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string "email"
    t.string "password"
  end

end
