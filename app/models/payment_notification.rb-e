class PaymentNotification < ActiveRecord::Base
  belongs_to :used_book
  serialize :params
  after_create :mark_used_book_as_promoted
private
  def mark_used_book_as_promoted
    if self.status == "Completed"
      self.used_book.update_attribute(:promoted, true)
    end
  end
end
