class CreateBookTransactions < ActiveRecord::Migration
  def self.up
    create_table :book_transactions do |t|
      t.integer :user_id
      t.integer :used_book_id

      t.timestamps
    end
  end

  def self.down
    drop_table :book_transactions
  end
end
