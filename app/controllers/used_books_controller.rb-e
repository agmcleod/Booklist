class UsedBooksController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  # GET /used_books
  # GET /used_books.xml
  def index
    @used_books = UsedBook.where(:status => UsedBook.status_to_i('For Sale'), :promoted => true).includes(:book, :user).order('used_books.created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @used_books }
    end
  end

  # GET /used_books/1
  # GET /used_books/1.xml
  def show
    @used_book = UsedBook.find(params[:id])
    @book = @used_book.book
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @used_book }
    end
  end

  # GET /used_books/new
  # GET /used_books/new.xml
  def new
    if !params[:isbn].blank?
      @used_book = UsedBook.new
      @used_book.isbn = params[:isbn] || ''
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @used_book }
      end
    else
      flash[:error] = "Please select find your book first"
      redirect_to browse_path
    end
  end
  
  def browse
    @items = Array.new
    @keywords = params[:criteria] || ''
    if request.post?
      unless @keywords.blank?
        @items = Book.get_amazon_data(@keywords)
      else
        flash[:error] = 'Please provide some keywords such as the title of the book to search.'
      end
      if @items.blank? or @items.empty?
        flash[:error] = 'Could not find any books from amazon by that criteria.'
      end
    end    
    respond_to do |format|
      format.html
    end
  end

  # GET /used_books/1/edit
  def edit
    if @used_book.is_owner?(session[:user_id])
      @used_book = UsedBook.find(params[:id])
    else
      unauthorized_action
    end
  end

  # POST /used_books
  # POST /used_books.xml
  def create
    @used_book = UsedBook.new(params[:used_book])
    book = save_book_if_needed(@used_book.isbn)
    if !book.nil?
      @used_book.book_id = book.id
      @used_book.user_id = session[:user_id]
      @used_book.status = UsedBook.status_to_i('For Sale')
      if @used_book.save
        flash[:notice] = 'UsedBook was successfully created.'
        redirect_to(@used_book)
      else
        render :action => "new", :locals => { :type => "Add" }
      end
    else
      flash[:error] = "Book could not be saved, please search it and try again"
      redirect_to browse_path
    end
  end
  
  # Processes request when user clicks the buy now button
  # Checks if the user has made the request, if not it adds it to the database
  # An email is sent to the owner to notify them of the request
  def buy_now
    book_id = params[:id]
    if !params[:id].nil? && request.post?
      begin
        @used_book = UsedBook.find(params[:id])
        if @used_book.user.id == session[:user_id]
          flash[:error] = "You can't buy your own book, that would just be weird."
         elsif UsedBook.request_exists?(@used_book, session[:user_id])
          flash[:error] = "You already sent a buy request for this book."
        else
          bt = @used_book.book_transactions.build(:user_id => session[:user_id])
          UserMailer.buy_request(@used_book.user, @used_book, bt.user).deliver
          if bt.save
            flash[:notice] = 'Buy request has been made. The seller of the book has been notified. You will receive an email upon
              acceptance.'
          else
            flash[:error] = 'An error occured trying to save your buy request, please try again or contact support.'
          end
        end
        redirect_to used_book_path(@used_book.id)
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Sorry but that used book could not be found, please refresh your search and select another suitable result."
        redirect_to used_books_path
      end
    else
      flash[:error] = "Please find the book you wish to purchase, and click the \"Buy Now\" link to purchase it from the seller"
      redirect_to used_books_path
    end
  end
  
  def accept_buy_request
    if !params[:id].nil? && !params[:user_id].nil?
      begin
        @used_book = UsedBook.includes(:book).select('books.title').find(params[:id])
        @user_id = params[:user_id]
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Could not find an used book by the id."
        redirect_to used_books_path
      end
    else
      flash[:error] = "To accept a buy request, please click the link on the email that was sent."
      redirect_to used_books_path
    end
  end
  
  def send_contact_info
    if request.post?
      unless params[:user_id].nil? || params[:used_book_id].nil?
        @message = params[:message]
        @used_book = UsedBook.find(params[:used_book_id])
        @used_book.update_attribute(:status, UsedBook.status_to_i('In Transaction'))
      
        UserMailer.notify_user_of_accepted_request(@used_book, User.find(params[:user_id]), @message).deliver
        transactions_to_destroy = BookTransaction.where(['user_id <> ? && used_book_id = ?', params[:used_id], @used_book.id])
        BookTransaction.delete(transactions_to_destroy)
      
        redirect_to used_books_path
        flash[:notice] = "Your message has been sent"
      else
        flash[:error] = "An error occured retrieving the used_book and the correct user information. Please try accepting again, or
          <a href=\"/support\">contact</a> support."
      end
    else
      redirect_to used_books_path
      flash[:error] = ""
    end
  end
  
  def set_book_to_sold
    if request.post? && !params[:id].nil?
      begin
        @used_book = UsedBook.find(params[:id])
        @used_book.update_attributes({ :status => UsedBook.status_to_i('Sold'), :promoted => false })
        flash[:notice] = "Congratulations on selling your book. It has been removed from search,
          but we'll keep it on your profile page for your own records."
        redirect_to used_books_path
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Used book by that id could not be found"
        redirect_to used_books_path
      end
    elsif !params[:id].nil?
      redirect_to used_books_path(params[:id])
    else
      redirect_to used_books_path
    end    
  end

  # PUT /used_books/1
  # PUT /used_books/1.xml
  def update
    @used_book = UsedBook.find(params[:id])
    if is_owner_or_admin? @used_book.user_id
      if @used_book.update_attributes(params[:used_book])
        flash[:notice] = 'UsedBook was successfully updated.'
        redirect_to @used_book
      else
        render :action => "edit"
      end
    else
      unauthorized_action
    end
  end

  # DELETE /used_books/1
  # DELETE /used_books/1.xml
  def destroy
    @used_book = UsedBook.find(params[:id])
    if is_owner_or_admin? @used_book.user_id 
      @used_book.destroy
      flash[:notice] = "That book has been removed."
      redirect_to used_books_path
    else
      unauthorized_action
    end
  end
  
private

  def save_book_if_needed(isbn)
    book = Book.find_by_isbn(isbn)
    if !book
      @book = Book.new
      @book.isbn = isbn
      @items = Book.get_amazon_data(@book.isbn)
      if @items.size >= 1
        item = @items[0]
        attribs = item.item_attributes[0]
        @book.title = attribs.title.to_s
        @book.author = attribs.author.to_s
        @book.isbn = item.asin.to_s
        @book.medium_image_path = item.medium_image[0].url.to_s
        @book.small_image_path = item.small_image[0].url.to_s
        @book.amazon_link = item.detail_page_url.to_s
        if @book.save
          return @book
        else
          return nil
        end
      else
        return nil
      end
    else
      # return the book if need be
      return book
    end
  end
  
  def unauthorized_action
    flash[:error] = 'You must be an admin or an owner of the book to do that.'
    redirect_to used_books_path
  end
end
