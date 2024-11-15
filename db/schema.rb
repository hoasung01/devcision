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

ActiveRecord::Schema[7.1].define(version: 2024_11_14_163604) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "algorithm_benchmarks", force: :cascade do |t|
    t.bigint "algorithm_implementation_id", null: false
    t.integer "input_size"
    t.string "input_type"
    t.decimal "execution_time"
    t.decimal "memory_usage"
    t.json "metrics"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algorithm_implementation_id", "input_size", "input_type"], name: "index_algorithm_benchmarks_on_impl_size_and_type", unique: true
    t.index ["algorithm_implementation_id"], name: "index_algorithm_benchmarks_on_algorithm_implementation_id"
  end

  create_table "algorithm_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug"
    t.text "description"
    t.string "icon"
    t.integer "display_order"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_algorithm_categories_on_name"
    t.index ["slug"], name: "index_algorithm_categories_on_slug"
  end

  create_table "algorithm_complexities", force: :cascade do |t|
    t.bigint "algorithm_id", null: false
    t.string "operation_type"
    t.string "best_case"
    t.string "average_case"
    t.string "worst_case"
    t.text "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algorithm_id", "operation_type"], name: "index_algorithm_complexities_on_algorithm_id_and_operation_type", unique: true
    t.index ["algorithm_id"], name: "index_algorithm_complexities_on_algorithm_id"
  end

  create_table "algorithm_examples", force: :cascade do |t|
    t.bigint "algorithm_id", null: false
    t.string "title", null: false
    t.text "description"
    t.text "input_data"
    t.text "output_data"
    t.text "explanation"
    t.integer "difficulty_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algorithm_id"], name: "index_algorithm_examples_on_algorithm_id"
  end

  create_table "algorithm_implementations", force: :cascade do |t|
    t.bigint "algorithm_id", null: false
    t.string "language", null: false
    t.text "code", null: false
    t.text "explanation"
    t.json "test_cases"
    t.boolean "verified", default: false
    t.integer "votes_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algorithm_id", "language"], name: "index_algorithm_implementations_on_algorithm_id_and_language", unique: true
    t.index ["algorithm_id"], name: "index_algorithm_implementations_on_algorithm_id"
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
    t.string "visualization_type"
    t.index ["algorithm_type_id", "name"], name: "index_algorithms_on_algorithm_type_id_and_name", unique: true
    t.index ["algorithm_type_id"], name: "index_algorithms_on_algorithm_type_id"
    t.index ["slug"], name: "index_algorithms_on_slug", unique: true
  end

  create_table "unit_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug"
    t.text "description"
    t.string "icon"
    t.integer "display_order"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_unit_categories_on_slug", unique: true
  end

  create_table "unit_comparisons", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.string "title", null: false
    t.text "description"
    t.decimal "value"
    t.string "comparison_type"
    t.json "metadata"
    t.integer "difficulty_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id", "value"], name: "index_unit_comparisons_on_unit_id_and_value"
    t.index ["unit_id"], name: "index_unit_comparisons_on_unit_id"
  end

  create_table "unit_conversions", force: :cascade do |t|
    t.bigint "from_unit_id", null: false
    t.bigint "to_unit_id", null: false
    t.decimal "conversion_factor", null: false
    t.text "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_unit_id", "to_unit_id"], name: "index_unit_conversions_on_from_unit_id_and_to_unit_id", unique: true
    t.index ["from_unit_id"], name: "index_unit_conversions_on_from_unit_id"
    t.index ["to_unit_id"], name: "index_unit_conversions_on_to_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "unit_category_id", null: false
    t.string "name", null: false
    t.string "symbol"
    t.decimal "base_value"
    t.string "base_unit"
    t.text "description"
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_category_id", "symbol"], name: "index_units_on_unit_category_id_and_symbol", unique: true
    t.index ["unit_category_id"], name: "index_units_on_unit_category_id"
  end

  add_foreign_key "algorithm_benchmarks", "algorithm_implementations"
  add_foreign_key "algorithm_complexities", "algorithms"
  add_foreign_key "algorithm_examples", "algorithms"
  add_foreign_key "algorithm_implementations", "algorithms"
  add_foreign_key "algorithm_types", "algorithm_categories"
  add_foreign_key "algorithms", "algorithm_types"
  add_foreign_key "unit_comparisons", "units"
  add_foreign_key "unit_conversions", "units", column: "from_unit_id"
  add_foreign_key "unit_conversions", "units", column: "to_unit_id"
  add_foreign_key "units", "unit_categories"
end
