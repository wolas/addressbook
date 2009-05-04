class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :company

  validates_presence_of :name, :surname, :phone, :email

  before_save :downcase_name

  def generate_password
    pass = ('a'..'z').to_a.sort_by{ rand }.to_s
    self.password = pass
    self.password_confirmation = pass
  end

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
