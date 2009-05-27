module UsersHelper
  def widget_for user, surname = false
    render :partial => 'users/widget', :locals => {:user => user, :surname => surname}
  end

  def admin?
    current_admin
  end
end
