class User < ActiveRecord::Base
  CSV_ORDER = [:surname, :name, :phone, :mobile, :fax, :email]
  ATTS = "name, surname, id, phone, mobile, fax, email, skype, company_id, avatar_file_name"
  acts_as_authentic

  belongs_to :company

  validates_presence_of :name, :surname
  validates_uniqueness_of :email, :if => lambda {|user| user.email}
  validates_uniqueness_of :login

  before_save :downcase_all

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "35x35>" }, :default_url => "face.png"

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

  def downcase_all
    self.name = name.downcase
    self.surname = surname.downcase
    self.email = email.downcase if email
  end

  def skype?
    return false if skype.nil? or skype.empty?
    true
  end
end
