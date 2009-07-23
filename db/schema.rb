# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090723145134) do

  create_table "admins", :force => true do |t|
    t.string  "login"
    t.string  "password_salt"
    t.string  "crypted_password"
    t.string  "persistence_token"
    t.integer "user_id"
  end

  create_table "companies", :force => true do |t|
    t.string "name"
    t.string "city"
    t.string "street"
    t.string "number"
    t.string "postcode"
    t.string "phone"
    t.string "fax"
    t.string "iva"
  end

  create_table "users", :force => true do |t|
    t.string   "surname"
    t.string   "phone"
    t.string   "mobile"
    t.string   "fax"
    t.string   "email"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",               :default => false
    t.string   "skype"
    t.string   "name"
    t.string   "access_code"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.string   "crypted_password",    :default => "",    :null => false
    t.string   "password_salt",       :default => "",    :null => false
    t.string   "persistence_token",   :default => "",    :null => false
  end

end
