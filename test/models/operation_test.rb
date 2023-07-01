require "test_helper"

class OperationTest < ActiveSupport::TestCase
  def setup
    @category = Category.create(name: 'Test Category', description: 'Test Description')
  end

  test 'foreign key relationship' do
    operation = Operation.new(category: @category)
    assert_equal @category, operation.category
  end

  test 'valid operation' do
    operation = Operation.new(
      category: @category,
      amount: 10,
      odate: Date.today,
      description: 'Test Description'
    )
    assert operation.valid?
  end

  test 'invalid amount' do
    operation = Operation.new(
      category: @category,
      amount: 0,
      odate: Date.today,
      description: 'Test Description'
    )
    assert_not operation.valid?

    operation.amount = -5
    assert_not operation.valid?
  end

  test 'invalid odate' do
    operation = Operation.new(
      category: @category,
      amount: 10,
      odate: nil,
      description: 'Test Description'
    )
    assert_not operation.valid?
  end

  test 'invalid description' do
    operation = Operation.new(
      category: @category,
      amount: 10,
      odate: Date.today,
      description: nil
    )
    assert_not operation.valid?
  end

  test 'operation_type enum' do
    assert_raises ArgumentError do
      Operation.create(
        category: @category,
        amount: 10,
        odate: Date.today,
        description: 'Test Description',
        operation_type: 'invalid'
      )
    end
  end
end
