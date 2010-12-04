class UserMailer < ActionMailer::Base
  default :from => "booklist.donotreply@gmail.com"
  def password_reset_confirmation(user, password)
    @user = user
    @password = password
    mail(:to => "#{user.display_name} <#{user.email}>", :subject => "Password reset - FiveWhiteboard")
  end
  
  def buy_request(to_user, used_book, buyer)
    @user = to_user
    @used_book = used_book
    @buyer = buyer
    mail(:to => "#{@user.display_name} <#{@user.email}>", :subject => "#{buyer.display_name} wants to buy your book")
  end
  
  def notify_user_of_accepted_request(used_book, user, message)
    @user = user
    @used_book = used_book
    @message = message
    Rails.logger.debug "#{@user.display_name} <#{@user.email}> subj: Buy request accepted."
    mail(:to => "#{@user.display_name} <#{@user.email}>", :subject => "Buy request accepted")
  end
  
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{@user.display_name} <#{@user.email}>", :subject => "Thank you for registering on booklist")
  end
end
