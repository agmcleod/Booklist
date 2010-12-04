class UsedBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :book_transactions
  
  validates_presence_of :isbn, :description
  validates_numericality_of :price
  validates_length_of :tags, :maximum => 50
  validate :price_must_be_at_least_a_cent
  validate :tags_must_not_have_trailing_comma
  
  def status_array
    UsedBook.status_array
  end
  
  def self.status_array
    ['For Sale', 'In Transaction', 'Sold']
  end
  
  def status_to_s(i = nil)
    index = i || self.status
    self.status_array[index]
  end
  
  def self.status_to_s(i = nil)
    index = i || self.status
    self.status_array[index]
  end
  
  def self.status_to_i(name)
    self.status_array.index name
  end
  
  def self.request_exists?(used_book, user_id)
    exists = false
    used_book.book_transactions.each do |transaction|
      if transaction.user.id.to_i == user_id.to_i
        exists = true
        break
      end
    end
    exists
  end
  
  def is_owner?(user_id)
    if self.user_id.to_i == user_id.to_i
      return true
    else
      return false
    end
  end
  
  def paypal_url(return_url, notify_url)
    values = {
      :business => 'seller_1279398933_biz@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :notify_url => notify_url
    }
    values.merge!({
      "amount_1" => self.price,
      "item_name_1" => self.book.title,
      "item_number_1" => self.id
    })
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
  
protected
  def price_must_be_at_least_a_cent
    errors.add(:price, 'should be at least 0.01') if price.nil? || price < 0.01
  end
  
  def tags_must_not_have_trailing_comma
    end_of_tags = tags.strip
    end_of_tags = end_of_tags[end_of_tags.size-1,1]
    if /,/ =~ end_of_tags
      errors.add(:tags, 'cannot end with a comma')
    end
  end
end
