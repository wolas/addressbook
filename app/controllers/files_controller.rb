class FilesController < ApplicationController
  require 'fastercsv'

  def index

  end

  def upload
    @valid_users = []
    @invalid_users = []

    FasterCSV.foreach(params[:file].path, :skip_blanks => true) do |name, surname, email, phone, fax, mobile|
      next if name.nil?
      next if name.include? 'Name'
      next if name.include? 'name'

      user = User.new(:name => name, :surname => surname, :phone => phone, :mobile => mobile, :email => email)
      user.generate_password
      user.login = "#{name} #{surname}".gsub("'", "")
      user.email = "email_of_#{name}_#{surname}@test.com" unless email

      if params[:dry_run] ? user.valid? : user.save
        @valid_users << user
      else
        @invalid_users << user
      end
    end
    flash[:notice] = "#{@valid_users.size} users were added to the database" unless @valid_users.empty?
    flash[:error] = "#{@invalid_users.size} users were invalid" unless @invalid_users.empty?
    render :action => :index
  end

  def upload_result
  end
end
