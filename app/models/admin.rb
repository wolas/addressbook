class Admin < ActiveRecord::Base
  belongs_to :user
  acts_as_authentic

  validates_presence_of :user
end
