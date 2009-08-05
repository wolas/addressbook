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

ActiveRecord::Schema.define(:version => 20090804153512) do

  create_table "admins", :force => true do |t|
    t.string  "login"
    t.string  "password_salt"
    t.string  "crypted_password"
    t.string  "persistence_token"
    t.integer "user_id"
  end

  create_table "brands", :force => true do |t|
    t.string "name"
  end

  create_table "clients", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "brand_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
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

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.integer  "project_id"
    t.text     "description"
  end

  create_table "events_users", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "end_date"
    t.integer  "client_id"
    t.text     "description"
    t.boolean  "closed",      :default => false
    t.string   "colour"
    t.string   "state"
    t.string   "priority"
    t.string   "account"
    t.integer  "manager_id"
  end

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "stories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.text     "body"
    t.integer  "creator_id"
    t.datetime "created_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.datetime "end_date"
    t.integer  "project_id"
    t.boolean  "completed",   :default => false, :null => false
    t.text     "description"
    t.datetime "start_date"
  end

  create_table "tasks_art_director", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "user_id"
  end

  create_table "tasks_art_operative", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "user_id"
  end

  create_table "tasks_back_end_developer", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "user_id"
  end

  create_table "tasks_digital_ref", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "user_id"
  end

  create_table "tasks_flash_operative", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "user_id"
  end

  create_table "tasks_front_end_developer", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "user_id"
  end

  create_table "tasks_users", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "user_id"
  end

  create_table "teams", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "surname"
    t.string   "phone"
    t.string   "mobile"
    t.string   "fax"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
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
    t.string   "website"
    t.text     "more_information"
    t.string   "login"
  end

  create_table "users_stories", :force => true do |t|
    t.integer "user_id"
    t.integer "story_id"
    t.boolean "seen",     :default => false
  end

end
