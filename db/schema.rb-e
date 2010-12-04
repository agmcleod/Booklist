# This file is auto-generated from the current state of the database. Instead 
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your 
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100718234942) do

  create_table "book_transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "used_book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "isbn"
    t.string   "author"
    t.string   "medium_image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amazon_link"
    t.string   "small_image_path"
  end

  create_table "faq_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", :force => true do |t|
    t.string   "question"
    t.text     "answer"
    t.integer  "faq_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faqs", ["faq_category_id"], :name => "faqs_faq_categories_fkey"

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "used_book_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "tickets", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
  end

  create_table "used_books", :force => true do |t|
    t.string   "isbn"
    t.string   "tags"
    t.text     "description"
    t.decimal  "price",       :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "status"
    t.boolean  "promoted"
  end

  add_index "used_books", ["book_id"], :name => "used_books_books_fkey"
  add_index "used_books", ["user_id"], :name => "used_books_users_fkey"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.boolean  "disabled"
    t.string   "display_name"
  end

end
