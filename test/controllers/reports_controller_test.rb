require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get report_generator_url
    assert_response :success
    assert_not_nil assigns(:categories_data)
    assert_not_nil assigns(:operations_data)
  end

  test "should redirect to report_by_dates when report_by_date param is present" do
    get report_generator_url, params: { report_by_date: true, start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 30), operation_type: 'one' }
    assert_redirected_to report_by_dates_path(start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 30), operation_type: 'one')
  end

  test "should redirect to report_by_category when report_by_category param is present" do
    get report_generator_path, params: { report_by_category: true, start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 30), operation_type: 'one' }
    assert_redirected_to action: 'report_by_category', start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 30), operation_type: 'one'
  end

  test "should redirect to report_category_by_date when report_cat_date param is present" do
    get report_generator_path, params: { report_cat_date: true, start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 30), category_id: 1, operation_type: 'one' }
    assert_redirected_to report_category_by_date_path(start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 30), category_id: 1, operation_type: 'one')
  end

  test "should get report_by_category" do
    get report_by_category_path, params: { start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 30), operation_type: 'two' }
    assert_response :success
    assert_not_nil assigns(:data)
    assert_not_nil assigns(:labels)
  end

  test "should get report_by_dates" do
    get report_by_dates_path, params: { start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 30), operation_type: 'one' }
    assert_response :success
    assert_not_nil assigns(:amount)
    assert_not_nil assigns(:dates)
  end

  test "should get report_category_by_date" do
    get report_category_by_date_path, params: { start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 30), category_id: 1, operation_type: 'one' }
    assert_response :success
    assert_not_nil assigns(:cat_date_amount)
    assert_not_nil assigns(:cat_dates)
  end
end
