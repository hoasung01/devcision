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

ActiveRecord::Schema[7.1].define(version: 2024_11_09_022553) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "algorithm_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug"
    t.text "descrtiption"
    t.string "icon"
    t.integer "display_order"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_algorithm_categories_on_name"
    t.index ["slug"], name: "index_algorithm_categories_on_slug"
  end

  create_table "algorithm_types", force: :cascade do |t|
    t.bigint "algorithm_category_id", null: false
    t.string "name", null: false
    t.string "slug"
    t.text "description"
    t.integer "display_order"
    t.json "characteristics"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algorithm_category_id", "name"], name: "index_algorithm_types_on_algorithm_category_id_and_name", unique: true
    t.index ["algorithm_category_id"], name: "index_algorithm_types_on_algorithm_category_id"
    t.index ["slug"], name: "index_algorithm_types_on_slug", unique: true
  end

  create_table "algorithms", force: :cascade do |t|
    t.bigint "algorithm_type_id", null: false
    t.string "name", null: false
    t.string "slug"
    t.text "description"
    t.text "prerequisites"
    t.string "time_complexity_best"
    t.string "time_complexity_average"
    t.string "time_complexity_worst"
    t.string "space_complexity"
    t.boolean "stable"
    t.boolean "in_place"
    t.boolean "recursive"
    t.boolean "parallel_possible"
    t.integer "difficulty_level"
    t.json "use_cases"
    t.json "advantages"
    t.json "disadvantages"
    t.json "edge_cases"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algorithm_type_id", "name"], name: "index_algorithms_on_algorithm_type_id_and_name", unique: true
    t.index ["algorithm_type_id"], name: "index_algorithms_on_algorithm_type_id"
    t.index ["slug"], name: "index_algorithms_on_slug", unique: true
  end

  add_foreign_key "algorithm_types", "algorithm_categories"
  add_foreign_key "algorithms", "algorithm_types"
end
