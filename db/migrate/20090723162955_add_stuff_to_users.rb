class AddStuffToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :website, :string
    add_column :users, :more_information, :text
  end

  def self.down
    remove_column :users, :website
    remove_column :users, :more_information
  end
end
