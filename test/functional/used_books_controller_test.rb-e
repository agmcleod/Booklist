require 'test_helper'

class UsedBooksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:used_books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create used_book" do
    assert_difference('UsedBook.count') do
      post :create, :used_book => { }
    end

    assert_redirected_to used_book_path(assigns(:used_book))
  end

  test "should show used_book" do
    get :show, :id => used_books(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => used_books(:one).to_param
    assert_response :success
  end

  test "should update used_book" do
    put :update, :id => used_books(:one).to_param, :used_book => { }
    assert_redirected_to used_book_path(assigns(:used_book))
  end

  test "should destroy used_book" do
    assert_difference('UsedBook.count', -1) do
      delete :destroy, :id => used_books(:one).to_param
    end

    assert_redirected_to used_books_path
  end
end
