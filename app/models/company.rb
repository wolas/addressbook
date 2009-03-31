class Company < ActiveRecord::Base
  has_many :usersm, :order => 'login DESC'
end
