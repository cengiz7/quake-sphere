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

ActiveRecord::Schema[7.0].define(version: 2022_05_09_200226) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "data_sources", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "slug", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "earthquakes", force: :cascade do |t|
    t.decimal "lat", precision: 9, scale: 7, null: false
    t.decimal "long", precision: 10, scale: 7, null: false
    t.decimal "depth", precision: 8, scale: 4
    t.decimal "magnitude", precision: 3, scale: 1, null: false
    t.string "magnitude_type", limit: 5
    t.datetime "time", null: false
    t.string "location_desc"
    t.bigint "main_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "data_source_id", null: false
    t.index ["data_source_id"], name: "index_earthquakes_on_data_source_id"
    t.index ["long", "lat"], name: "index_earthquakes_on_long_and_lat"
    t.index ["magnitude"], name: "index_earthquakes_on_magnitude"
    t.index ["main_id"], name: "index_earthquakes_on_main_id"
  end

  add_foreign_key "earthquakes", "data_sources"
  add_foreign_key "earthquakes", "earthquakes", column: "main_id"
end
