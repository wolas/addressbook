class CreateStats < ActiveRecord::Migration
  def self.up
    create_table :stats do |t|
      t.datetime :time

    end
  end

  def self.down
    drop_table :stats
  end
end
