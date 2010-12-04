require 'test_helper'

class FaqCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:faq_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create faq_category" do
    assert_difference('FaqCategory.count') do
      post :create, :faq_category => { }
    end

    assert_redirected_to faq_category_path(assigns(:faq_category))
  end

  test "should show faq_category" do
    get :show, :id => faq_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => faq_categories(:one).to_param
    assert_response :success
  end

  test "should update faq_category" do
    put :update, :id => faq_categories(:one).to_param, :faq_category => { }
    assert_redirected_to faq_category_path(assigns(:faq_category))
  end

  test "should destroy faq_category" do
    assert_difference('FaqCategory.count', -1) do
      delete :destroy, :id => faq_categories(:one).to_param
    end

    assert_redirected_to faq_categories_path
  end
end
