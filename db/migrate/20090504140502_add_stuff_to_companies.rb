class AddStuffToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :number, :string
    add_column :companies, :postcode, :string
    add_column :companies, :phone, :string
    add_column :companies, :fax, :string
    add_column :companies, :iva, :string
  end

  def self.down
    remove_column :companies, :number
    remove_column :companies, :iva
    remove_column :companies, :fax
    remove_column :companies, :phone
    remove_column :companies, :postcode
  end
end
