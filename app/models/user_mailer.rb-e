class UserMailer < ActionMailer::Base
  def password_reset_confirmation(user, password)
    recipients  user.email
    from        "donotreply@booklist.com"
    subject     "Password reset confirmation"
    body        :user => user, :password => password
  end
end
