class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :company

  validates_presence_of :name, :surname, :name

  before_save :downcase_name, :unique_name

  def unique_name
    errors.add(:name, 'must be unique') if User.first(:conditions => {:name => name, :surname => surname})
  end

  def full_name
    "#{surname}, #{name}"
  end

  def self.generate_access_code
    all = ('a'..'z').to_a + ('A'..'Z').to_a
    all.sort_by{ rand }.to_s
  end

  def generate_password
    pass = ('a'..'z').to_a.sort_by{ rand }.to_s
    self.password = pass
    self.password_confirmation = pass
  end

  def downcase_name
    self.login = login.downcase
    self.surname = surname.downcase
  end

  def skype?
    return false if skype.nil? or skype.empty?
    true
  end
end
