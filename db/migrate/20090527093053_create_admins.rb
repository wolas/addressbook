class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :login
      t.string :password_salt
      t.string :crypted_password
      t.string :persistence_token
      t.integer :user_id

    end
  end

  def self.down
    drop_table :admins
  end
end
