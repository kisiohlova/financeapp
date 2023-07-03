class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, numericality: { greater_than: 0 }, presence: true
  validates :odate, presence: true
  validates :description, presence: true

  enum operation_type: { income: 'income', expense: 'expense' }

  paginates_per 5
end
