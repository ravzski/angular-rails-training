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

ActiveRecord::Schema.define(version: 20170725181727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "token", limit: 255
    t.string "ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.datetime "last_active_at"
    t.string "device"
    t.string "device_id"
    t.string "browser"
  end

  create_table "activity_logs", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "schedule_id"
    t.integer "stage_id"
    t.integer "time_in"
    t.integer "time_out"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.boolean "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
  end

  create_table "assistants", id: :serial, force: :cascade do |t|
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "supplier_id"
    t.string "status", default: "active"
    t.datetime "deleted_at"
    t.boolean "is_banned", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.integer "card_type_id"
    t.integer "card_id"
    t.index ["card_type_id"], name: "index_assistants_on_card_type_id"
  end

  create_table "ban_reason_types", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "ban_reasons", force: :cascade do |t|
    t.integer "ban_reason_type_id"
    t.string "reasonable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "reasonable_id"
    t.index ["reasonable_id"], name: "index_ban_reasons_on_reasonable_id"
  end

  create_table "blacklists", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "user_type"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_blacklists_on_user_id"
  end

  create_table "card_types", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "card_type_id"
    t.string "number"
    t.integer "identifiable_id"
    t.string "identifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "primary", default: false
  end

  create_table "configs", force: :cascade do |t|
    t.string "name"
    t.string "value"
  end

  create_table "contact_details", force: :cascade do |t|
    t.integer "contact_type_id"
    t.integer "contactable_id"
    t.string "contactable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "contact"
  end

  create_table "contact_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "coordinators", force: :cascade do |t|
    t.string "middle_name"
    t.integer "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "first_name"
    t.string "last_name"
  end

  create_table "csv_logs", force: :cascade do |t|
    t.string "resource_type"
    t.string "error_message"
    t.string "row_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "docks", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "description"
    t.boolean "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drivers", id: :serial, force: :cascade do |t|
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "supplier_id"
    t.string "status", default: "active"
    t.datetime "deleted_at"
    t.boolean "is_banned", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.integer "card_type_id"
    t.integer "card_id"
    t.index ["card_type_id"], name: "index_drivers_on_card_type_id"
  end

  create_table "logs", id: :serial, force: :cascade do |t|
    t.integer "ref_id"
    t.string "ref_type", limit: 255
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "creator_id"
    t.string "token"
    t.text "creator_details"
    t.text "log_details"
    t.string "action"
    t.string "updated_field"
    t.string "from_value"
    t.string "to_value"
    t.integer "user_id"
  end

  create_table "module_lists", force: :cascade do |t|
    t.string "parent_module", limit: 255
    t.string "code", limit: 255
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.string "actions", limit: 255
    t.string "endpoints", limit: 255
    t.string "ref_id", limit: 255
    t.integer "sub_ref_id"
    t.index ["code"], name: "index_module_lists_on_code", unique: true
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "role_id"
    t.string "actions", limit: 255
    t.string "code", limit: 255
    t.string "role_code"
    t.string "module_code"
    t.index ["module_code"], name: "index_permissions_on_module_code"
    t.index ["role_code"], name: "index_permissions_on_role_code"
    t.index ["role_id"], name: "index_permissions_on_role_id"
  end

  create_table "rfid_guns", force: :cascade do |t|
    t.string "code"
    t.string "serial_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "rfids", id: :serial, force: :cascade do |t|
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
    t.datetime "deleted_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "status", default: "active"
    t.string "alias", limit: 255
    t.string "code"
    t.datetime "deleted_at"
    t.index ["code"], name: "index_roles_on_code"
  end

  create_table "schedule_docks", force: :cascade do |t|
    t.integer "schedule_id"
    t.integer "dock_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dock_id"
    t.index ["dock_code"], name: "index_schedule_docks_on_dock_code"
    t.index ["schedule_id"], name: "index_schedule_docks_on_schedule_id"
  end

  create_table "schedules", id: :serial, force: :cascade do |t|
    t.integer "truck_id"
    t.integer "supplier_id"
    t.integer "driver_id"
    t.integer "assistant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state", default: "unstarted"
    t.datetime "deleted_at"
    t.integer "time_in"
    t.integer "time_out"
    t.date "scheduled_date"
    t.integer "actual_time_in"
    t.integer "actual_time_out"
    t.string "dock_code"
    t.boolean "is_recurring", default: false
    t.date "recurring_until"
    t.string "recurring_group"
    t.integer "created_by"
    t.integer "deleted_by"
    t.string "recurring_days", default: [], array: true
    t.date "end_date"
    t.index ["deleted_at"], name: "index_schedules_on_deleted_at"
    t.index ["recurring_group"], name: "index_schedules_on_recurring_group"
    t.index ["supplier_id"], name: "index_schedules_on_supplier_id"
  end

  create_table "stages", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "transition_to_stage"
    t.integer "area_id"
    t.integer "stage_id"
    t.index ["stage_id"], name: "index_stages_on_stage_id"
  end

  create_table "suppliers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "active"
    t.datetime "deleted_at"
    t.string "color"
    t.string "company"
    t.boolean "is_banned", default: false
  end

  create_table "trucks", id: :serial, force: :cascade do |t|
    t.string "plate_number"
    t.string "official_receipt_number"
    t.string "certificate_number"
    t.string "make"
    t.string "model"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "supplier_id"
    t.string "status", default: "active"
    t.integer "rfid_id"
    t.datetime "deleted_at"
    t.boolean "is_banned", default: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "email", limit: 255
    t.string "username", limit: 255
    t.string "encrypted_password", limit: 255
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_locked", default: false
    t.boolean "is_deleted", default: false
    t.datetime "deleted_at"
    t.boolean "super_admin", default: false
    t.string "role_code"
    t.integer "role_id"
    t.boolean "is_banned", default: false
    t.index ["role_code"], name: "index_users_on_role_code"
  end

end
