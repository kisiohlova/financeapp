class AddOperationTypeToOperations < ActiveRecord::Migration[7.0]
  def change
    add_column :operations, :operation_type, :string
  end
end
