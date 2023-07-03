class MainController < ApplicationController
  def index
    operation_types = ['income', 'expense']
    @messages = {}
    operation_types.each do |operation_type|
      total_amount = Operation.where(operation_type: operation_type)
                              .where(odate: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
                              .sum(:amount)
      @messages[operation_type] = total_amount > 0 ? "Total #{operation_type} for #{Time.now.strftime("%B")}: #{total_amount} ₴" : "You have no #{operation_type.pluralize} in #{Time.now.strftime("%B")}."
    end
  @last_ops = Operation.all.order(odate: :asc).pluck(:description, :operation_type, :amount, :odate, :id).last(5)
  end
end
