class FilesController < ApplicationController
  require 'fastercsv'

  before_filter :require_admin, :except => [:download, :show_download]

  def index

  end

  def upload
    @valid_users = []
    @invalid_users = []

    unless params[:file]
      flash[:error] = "You must supply a valid file"
      redirect_to(:action => :index) and return
    end

    FasterCSV.foreach(params[:file].path, :skip_blanks => true) do |name, surname, phone, mobile, fax, email|
      next if name.nil?
      next if name.include?('Name') or name.include?('name')

      user = User.new(:company_id => params[:user][:company], :name => name, :surname => surname, :phone => phone, :mobile => mobile, :email => email)

      if params[:dry] ? user.valid? : user.save
        @valid_users << user
      else
        @invalid_users << user
      end
    end
    flash[:notice] = "#{@valid_users.size} users are valid" unless @valid_users.empty?
    flash[:error] = "#{@invalid_users.size} users are invalid" unless @invalid_users.empty?
    render :action => :index
  end

  def show_download

  end

  def download
    file = FasterCSV.generate_line User::CSV_ORDER
    id = params[:company][:id] if params[:company]
    users = id ? User.find_all_by_company_id(id) : User.all

    users.each { |u| file += FasterCSV.generate_line(User::CSV_ORDER.map { |attribute| u.attributes[attribute.to_s] }) }
    send_data file, :type => "text/plain", :filename=> "users.csv", :disposition => 'attachment'
  end
end
