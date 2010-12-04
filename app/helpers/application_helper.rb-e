# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def partial_submit(f, text, type = nil)
    if !type.nil?
      f.submit "#{type} #{text}", :class => "largeBtn"
    elsif !text.nil? && controller.action_name == "new"
      f.submit "Create #{text}", :class => "largeBtn"
    elsif !text.nil? && controller.action_name == "edit"
      f.submit "Update #{text}", :class => "largeBtn"
    end
  end
  def current_user
    return nil if session[:user_id].nil?
    @user = User.find(session[:user_id])
  end
  
  def title(title)
    content_for(:title) { title }
  end
  
  def sold_by(used_book)
    is_owner?(session[:user_id], used_book.user.id) ? 'you' : link_to(used_book.user.display_name, user_path(used_book.user))
  end
end
