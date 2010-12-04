class CreateUsedBooks < ActiveRecord::Migration
  def self.up
    create_table :used_books do |t|
      t.string :isbn
      t.string :tags
      t.text :description
      t.decimal :price
      t.timestamps
    end
  end

  def self.down
    drop_table :used_books
  end
end
