require "test_helper"

class OperationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operation = operations(:one)
    @category = categories(:one)
  end

  test "should get index" do
    get operations_url
    assert_response :success
    assert_not_nil assigns(:operations)
    assert_not_nil assigns(:categories)
  end

  test "should filter operations by category_id" do
    get operations_url, params: { category_id: @category.id }
    assert_response :success
    assert_equal [@operation], assigns(:operations)
  end

  test "should get new" do
    get new_operation_url
    assert_response :success
    assert_not_nil assigns(:operation)
    assert_not_nil assigns(:categories)
  end

  test "should create operation" do
    assert_difference("Operation.count") do
      post operations_url, params: { operation: { amount: @operation.amount, category_id: @operation.category_id, description: @operation.description, odate: @operation.odate, operation_type: @operation.operation_type } }
    end

    assert_redirected_to operation_path(assigns(:operation))
  end

  test "should show operation" do
    get operation_url(@operation)
    assert_response :success
    assert_not_nil assigns(:operation)
  end

  test "should get edit" do
    get edit_operation_url(@operation)
    assert_response :success
    assert_not_nil assigns(:operation)
    assert_not_nil assigns(:categories)
  end

  test "should update operation" do
    patch operation_url(@operation), params: { operation: { amount: @operation.amount, category_id: @operation.category_id, description: @operation.description, odate: @operation.odate, operation_type: @operation.operation_type } }
    assert_redirected_to operation_path(assigns(:operation))
  end

  test "should destroy operation" do
    assert_difference("Operation.count", -1) do
      delete operation_url(@operation)
    end

    assert_redirected_to operations_path
  end
end
