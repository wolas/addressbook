class Notifier < ActionMailer::Base
  def send_access(recipient)
     recipients recipient.email
     from       "system@addressbook.com"
     subject    "Access to your addressbook account"
     body       :user => recipient
   end
end
