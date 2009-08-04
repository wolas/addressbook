class CreateAll < ActiveRecord::Migration
  def self.up
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
    end
  end

  def self.down
    drop_table :users
    drop_table :companies
    drop_table :admins
  end
end
