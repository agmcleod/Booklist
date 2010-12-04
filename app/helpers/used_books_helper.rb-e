module UsedBooksHelper
  def is_owner?(user, id)
    if (user.class == User && id == user.id) || user == id
      return true
    else
      return false
    end
  end
  
  def is_owner_or_admin?(user, id)
    return false if user.nil?
    if is_owner?(user, id) || user.is_admin?
      return true
    else
      return false
    end
  end
end
