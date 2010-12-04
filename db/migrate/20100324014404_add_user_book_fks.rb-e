class AddUserBookFks < ActiveRecord::Migration
  def self.up
    add_column :used_books, :user_id, :integer
    add_column :used_books, :book_id, :integer
    add_foreign_key :used_books, :book_id, :books
    add_foreign_key :used_books, :user_id, :users
  end

  def self.down
    remove_foreign_key :used_books, :users
    remove_foreign_key :used_books, :books
    remove_column :used_books, :book_id
    remove_column :used_books, :user_id
  end
end
