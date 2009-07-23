module UsersHelper
  def admin?
    current_user and current_user.admin?
  end
end
