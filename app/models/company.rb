class Company < ActiveRecord::Base
  has_many :users, :order => 'login DESC'
  validates_presence_of :name
end
