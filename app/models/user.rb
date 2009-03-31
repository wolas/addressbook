class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :company

  validates_presence_of :company

  before_save :downcase_name

  def downcase_name
    self.login = login.downcase
    self.surname = surname.downcase
  end

  def name
    result = login.capitalize
    result += " " + surname.capitalize if surname
    result
  end

  def skype?
    return false if skype.nil? or skype.empty?
    true
  end
end
