class User < ActiveRecord::Base
  CSV_ORDER = [:surname, :name, :phone, :mobile, :fax, :email]
  ATTS = "name, surname, id, phone, mobile, fax, email, skype, company_id"

  belongs_to :company
  has_one :admin

  validates_presence_of :name, :surname, :email
  validates_uniqueness_of :email

  before_save :downcase_all

  def full_name
    "#{surname}, #{name}"
  end

  def admin?
    not admin.nil?
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
    self.surname = surname.downcase
    self.email = email.downcase
  end

  def skype?
    return false if skype.nil? or skype.empty?
    true
  end
end
