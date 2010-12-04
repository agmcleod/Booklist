# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  layout 'used_books'

  # code to include amazon
  # require 'rubygems'
  
  #require 'amazon/aws/search'
  
  #include Amazon::AWS
  #include Amazon::AWS::Search
  
  protect_from_forgery
  
  def is_logged_in
    return true if session[:user_id] != nil
  end

  def login_required
    if is_logged_in
      return true
    else
      you_must_log_in
    end
  end

  def login_prohibited
    unless is_logged_in
      return true
    else
      flash[:error] = "You must log out in order to do that"
      redirect_to root_path
    end
  end

  def admin_required
    user = current_user
    if user && current_user.is_admin?
      return true
    else
      you_must_be_an_admin
    end
  end

  def current_user
    return nil if session[:user_id].nil?
    @user = User.find(session[:user_id])
  end

  def you_must_log_in
    flash[:error] = "You must be logged in to do that"
    session[:refer_url] = request.request_uri
    redirect_to root_path
  end

  def you_must_be_an_admin
    flash[:error] = "You must be an admin to do that"
    redirect_to request.referrer
  end

  def redirect_to_referer_or_root
    unless session[:refer_url].blank?
      redirect_to session[:refer_url]
    else
      redirect_to root_path
    end
  end
  
  def is_owner?(id)
    owner = false
    if id == session[:user_id].to_i
      owner = true
    end
    owner
  end
  
  def is_owner_or_admin?(id)
    owner = false
    owner = is_owner?(id) || User.find(session[:user_id]).is_admin?
    owner
  end
end
