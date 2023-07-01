require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test 'name presence' do
    category = Category.new(name: 'Test Category', description: 'Test Description')
    assert category.valid?

    category.name = nil
    assert_not category.valid?
  end

  test 'name uniqueness' do
    Category.create(name: 'Existing Category', description: 'Test Description')
    category = Category.new(name: 'Existing Category', description: 'Another Description')
    assert_not category.valid?
  end

  test 'description presence' do
    category = Category.new(name: 'Test Category', description: 'Test Description')
    assert category.valid?

    category.description = nil
    assert_not category.valid?
  end

  test 'has many association' do
    category = Category.new(name: 'Test Category', description: 'Test Description')
    assert_respond_to category, :operations
  end

  test 'has many association deletion behavior' do
    category = Category.create(name: 'Test Category', description: 'Test Description')
    operation = Operation.create(category: category, amount: 10, odate: Date.today, description: 'Test Description')

    assert_difference('Operation.count', -1) do
    category.destroy
  end

    assert_not Operation.exists?(operation.id)
  end

  test 'saving and gathering' do
    new_category = Category.new(name: 'new category', description: 'new description')
    new_category.save()
    new_cat = Category.find_by(name: 'new category')
    assert_equal('new description', new_cat.description)
  end
end
