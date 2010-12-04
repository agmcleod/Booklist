class SessionsController < ApplicationController
  before_filter :login_prohibited, :only => [:create]
  before_filter :login_required, :only => [:destroy]

  # render new.html.erb
  def _login
    @user = User.new
    respond_to do |format|
      format.html
    end
  end

  def create
    begin
      user = User.authenticate(params[:email], params[:password])
      # if an error msg is being sent back, display it
      if !user.authenticated
        flash[:error] = 'Incorrect email or password entered. Please try again'
        redirect_to root_path
      # if the user is otherwise set
      elsif user.authenticated
        # if the user is disabled
        if user.disabled
          flash[:error] = "Your account has been disabled. If you feel this is done wrongly, please contact us in the support section"
          redirect_to root_path
        # all is well, set the user to session
        else
          flash[:notice] = "Logged in successfully"
          session[:user_id] = user.id
          redirect_to user_path(user.id)
        end
      # otherwise its not found, let the user know
      else
        respond_to do |format|
          flash[:error] = 'Incorrect email or password entered. Please try again'
          format.html { redirect_to root_path }
        end
      end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        flash[:error] = 'Incorrect email or password entered. Please try again'
        format.html { redirect_to root_path }
      end
    rescue Exception
      respond_to do |format|
        flash[:error] = 'Incorrect email or password entered. Please try again'
        format.html { redirect_to root_path }
      end
    end
  end

  def _logout
    @user = User.find_by_id(session[:user_id])
    respond_to do |format|
      format.html
    end
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      flash[:notice] = 'You have logged out successfully.'
      format.html { redirect_to root_path }
    end
  end
end

