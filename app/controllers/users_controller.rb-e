class UsersController < ApplicationController
  before_filter :login_required, :only => [:edit, :update, :user_cp, :change_password]
  before_filter :admin_required, :only => [:index, :destroy, :update_permissions]
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    @roles = Role.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @used_books = UsedBook.where(:user_id => params[:id]).order(:created_at)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    if is_owner? session[:user_id]
      @user = User.find(params[:id])
    else
      unauthorized_action
    end
  end
  
  def update_permissions
    if request.post?
      begin
        @user = User.find(params[:user][:id])
        @user.update_attribute(:disabled, params[:user][:disabled])
        @user.roles.each { |role| @user.roles.delete(role) }
        @user.roles << Role.find_by_name(params[:user][:roles])
        flash[:notice] = "Permissions have been updated successfully"
      rescue ActiveRecord::RecordNotFound
        flash[:error] = 'Invalid user id specified, user could not be found'
      rescue Exception
        flash[:error] = 'An error occured when trying to change the permissions'
      end
      redirect_to users_path
    else
      flash[:error] = "To change permissions, please visit the user management <a href=\"/users\">page</a>."
      redirect_to users_path
    end
  end

  # POST /users
  # POST /users.xml
  def create
    if request.post?
      @user = User.new(params[:user])
      @user.disabled = false
      @user.roles << Role.find_by_name('user')
      respond_to do |format|
        if verify_recaptcha(:model => @user, :message => 'Recaptcha validation failed, please retry') && @user.save
          flash[:notice] = 'Your account has been created, feel free to do a search on a book you wish to advertise.'
          session[:user_id] = @user.id
          format.html { redirect_to browse_path }
        else
          format.html { render :action => "new" }
        end
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def forgot_password
    if request.post?
      begin
        @user = User.find_by_email(params[:email])
        if @user
          temppassword = User.generate_password
          # set it to the user, and then secure it
          @user.password = temppassword
          @user.hashed_password = @user.secure_new_pw(temppassword)
          # so long as the updates are successful, continue
          if @user.update_attribute(:hashed_password, @user.hashed_password) &&
              @user.update_attribute(:salt, @user.salt)
            # TODO: enable mailer to send forgotpassword email
            logger.debug("temp: #{temppassword}")
            UserMailer.password_reset_confirmation(@user, temppassword).deliver
            flash[:notice] = "Password reset successfully! Please check your registered e-mail address for your temporary password"
          else
            flash[:error] = 'An error occured trying to reset your password.'
          end
        else
          flash[:error] = 'We could not find an account by that email address. Please check your spelling, <br />
            and if you are still having trouble contact support.'
        end
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "We could not find an account by that email address. Please check your spelling, <br />
          and if you are still having trouble contact support."
      end
    end
  end
  
  def change_password
    begin
      @user = User.find(session[:user_id])
      if request.put?
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
        @user.hashed_password = ""
        user = User.authenticate(@user.email, params[:user][:old_password])
        unless user.blank? || !user.authenticated
          if @user.update_attributes(params[:user])
            flash[:notice] = "Password Changed successfully!"
            redirect_to control_panel_path
          else
            respond_to do |format|
              format.html { render :action => 'change_password', :locals => { :user => @user } }
            end
          end
        else
          flash[:error] = "Old password does not match your current password"
          respond_to do |format|
            format.html { render :action => 'change_password', :locals => { :user => @user } }
          end
        end
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Sorry, but we could not find a user by that id"
      redirect_to user_cp_path
    rescue Exception
      flash[:error] = "Sorry, but we could not find a user by that id"
      redirect_to user_cp_path
    end
  end
  
  def user_cp
    if is_owner? session[:user_id]
      @used_books = UsedBook.where(:user_id => session[:user_id]).order(:created_at)
    else
      unauthorized_action
    end
  end
private
  def unauthorized_action
    flash[:error] = 'You do not have permission to do that.'
    redirect_to used_books_path
  end
end
