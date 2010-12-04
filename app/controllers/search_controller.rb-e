class SearchController < ApplicationController
  def search
    @results = Array.new
    @amazon_results = Array.new
    if request.post?
      unless params[:criteria].blank?
        criteria = params[:criteria]
        @results = UsedBook.paginate(:page => params[:page], :per_page => 10, :include => :book, :conditions => ["books.title like ? OR books.author like ? OR" + 
          " used_books.tags like ?", "%#{criteria}%", "%#{criteria}%", "%#{criteria}%"])
        if @results.blank? || @results.empty?
          @amazon_results = Book.get_amazon_data(criteria)
        end
      else
        flash[:error] = "Please provide some information about the book in the search bar below"
      end
    end
  end
end
