module TicketsHelper
  def ticket_row_colour(id)
    if id % 2 == 0
      ""
    else
      "ticketsRowGray"
    end
  end
  
  def show_tickets_index_header
    unless show_all_param_present?
      "Viewing all open tickets"
    else
      "Viewing all tickets"
    end
  end
  
  def show_open_tickets_link
    unless show_all_param_present?
      link_to "Show all tickets", "#{tickets_path}?show_all=true"
    else
      link_to "Show open tickets", tickets_path
    end
  end
  
  def show_all_param_present?
    if params[:show_all] && params[:show_all] == "true"
      return true
    else
      return false
    end
  end
end
