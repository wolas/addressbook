class AddAuthenticationForUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :crypted_password, :string, :null => false, :default => ""
    add_column :users, :password_salt, :string, :null => false, :default => ""
    add_column :users, :persistence_token, :string, :null => false, :default => ""
  end

  def self.down
    remove_column :users, :crypted_password
    remove_column :users, :password_salt
    remove_column :users, :persistence_token
  end
end
