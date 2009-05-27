class RemoveStuffFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :login
    remove_column :users, :crypted_password
    remove_column :users, :password_salt
    remove_column :users, :persistence_token
  end

  def self.down
    add_column :users, :login, :string
    add_column :users, :crypted_password, :string
    add_column :users, :password_salt, :string
    add_column :users, :persistence_token, :string
  end
end
