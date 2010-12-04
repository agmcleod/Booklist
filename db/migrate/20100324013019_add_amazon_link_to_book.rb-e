class AddAmazonLinkToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :amazon_link, :string, :length => 255
  end

  def self.down
    remove_column :books, :amazon_link
  end
end
