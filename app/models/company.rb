class Company < ActiveRecord::Base
  has_many :users, :order => 'login DESC'
end
