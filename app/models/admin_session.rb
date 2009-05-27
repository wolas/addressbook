class AdminSession < Authlogic::Session::Base
  authenticate_with Admin
end
