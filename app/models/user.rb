class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :company

  validates_presence_of :company
end
