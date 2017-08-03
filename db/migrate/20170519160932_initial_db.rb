class InitialDb < ActiveRecord::Migration[5.0]
  def change


    create_table "users", force: :cascade do |t|
      t.string   "first_name",             limit: 255
      t.string   "last_name",              limit: 255
      t.string   "email",                  limit: 255
      t.string   "username",                  limit: 255
      t.string   "encrypted_password",     limit: 255
      t.boolean  "is_active",                          default: true
      t.datetime "created_at",                                         null: false
      t.datetime "updated_at",                                         null: false
      t.boolean  "is_locked",                          default: false
      t.boolean  "is_deleted",                          default: false
    end

    create_table "access_tokens", force: :cascade do |t|
      t.integer  "user_id",    limit: 4
      t.string   "token",      limit: 255
      t.string   "ip",         limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "deleted_at"
      t.datetime "last_active_at"
      t.string "device"
      t.string "device_id"
      t.string "browser"
    end


  end
end
