require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { code: @item.code, customer_id: @item.customer_id, description: @item.description, discount: @item.discount, paid_amout: @item.paid_amout, payment_status: @item.payment_status, photo: @item.photo, retail_price: @item.retail_price, selling_price: @item.selling_price, size: @item.size, status: @item.status, token: @item.token, wholesale_price: @item.wholesale_price }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    patch :update, id: @item, item: { code: @item.code, customer_id: @item.customer_id, description: @item.description, discount: @item.discount, paid_amout: @item.paid_amout, payment_status: @item.payment_status, photo: @item.photo, retail_price: @item.retail_price, selling_price: @item.selling_price, size: @item.size, status: @item.status, token: @item.token, wholesale_price: @item.wholesale_price }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
