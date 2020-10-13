# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_11_110023) do

  create_table "fields", force: :cascade do |t|
    t.integer "synchronization_id", null: false
    t.string "name"
    t.string "platform"
    t.integer "line"
    t.boolean "is_comment"
    t.string "field_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["synchronization_id"], name: "index_fields_on_synchronization_id"
  end

  create_table "mappings", force: :cascade do |t|
    t.integer "source_field_id", null: false
    t.integer "target_field_id"
    t.boolean "bidirectional"
    t.integer "synchronization_id", null: false
    t.string "common_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["source_field_id"], name: "index_mappings_on_source_field_id"
    t.index ["synchronization_id"], name: "index_mappings_on_synchronization_id"
    t.index ["target_field_id"], name: "index_mappings_on_target_field_id"
  end

  create_table "synchronizations", force: :cascade do |t|
    t.string "name"
    t.string "source_platform"
    t.text "source_document"
    t.string "target_platform"
    t.text "target_document"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "fields", "synchronizations"
  add_foreign_key "mappings", "fields", column: "source_field_id"
  add_foreign_key "mappings", "fields", column: "target_field_id"
  add_foreign_key "mappings", "synchronizations"
end
