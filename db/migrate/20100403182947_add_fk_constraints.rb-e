class AddFkConstraints < ActiveRecord::Migration
  def self.up
    add_foreign_key :faqs, :faq_category_id, :faq_categories
  end

  def self.down
    remove_foreign_key :faqs, :faq_categories
  end
end
