# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_22_184004) do
  create_table "assignments", force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
    t.datetime "due_date"
    t.datetime "date_assigned"
    t.string "name"
    t.string "category"
    t.float "score"
    t.float "total_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_assignments_on_course_id"
    t.index ["student_id"], name: "index_assignments_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "student_id"
    t.string "name"
    t.float "average"
    t.datetime "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_courses_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "student_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assignments", "courses"
  add_foreign_key "assignments", "students"
  add_foreign_key "courses", "students"
end
