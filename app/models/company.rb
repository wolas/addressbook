class Company < ActiveRecord::Base
  has_many :users, :order => 'surname ASC'
  validates_presence_of :name
end
