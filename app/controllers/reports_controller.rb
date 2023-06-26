class ReportsController < ApplicationController
  def index
    @categories_data = Category.all.map { |c| [c.name, c.id] }

    if params[:report_by_date]
      redirect_to({
        action: 'report_by_dates',
        start_date: params[:start_date],
        end_date: params[:end_date]
      })
      elsif params[:report_by_category]
        redirect_to({
          action: 'report_by_category',
          start_date: params[:start_date],
          end_date: params[:end_date]
        })
      elsif params[:report_cat_date]
        redirect_to({
          action: 'report_category_by_date',
          start_date: params[:start_date],
          end_date: params[:end_date],
          category_id: params[:category_id]
        })
    end
  end

  def report_by_category
    ops = Category.joins(:operations)
                  .where('odate >= :start_date AND odate <= :end_date', { start_date: params[:start_date], end_date: params[:end_date].next })
                  .group('categories.name')
                  .pluck('categories.name', 'SUM(operations.amount)')
                  .map{ |o| o }
    @data = ops.map { |e| e[1] }
    @labels = ops.map { |e| e[0] }
  end

  def report_by_dates
    operations_data = Operation.where('odate >= :start_date AND odate <= :end_date',
                                {start_date: params[:start_date], end_date: params[:end_date].next})
                                .order(odate: :asc)
                                .map { |o| [o.odate.to_date.to_s, o.amount] }
    @amount = operations_data.map { |e| e[1] }
    @dates = operations_data.map { |e| e[0] }
  end

  def report_category_by_date
    category_by_date_ops = Operation.where('odate >= :start_date AND odate <= :end_date',
                                    {start_date: params[:start_date], end_date: params[:end_date].next})
                                    .where('category_id = :category_id', { category_id: params[:category_id] })
                                    .order(odate: :asc)
                                    .map { |o| [o.odate.to_date.to_s, o.amount] }
    @cat_name = Category.where('id = :category_id', { category_id: params[:category_id] }).pluck('name').first
    @cat_date_amount = category_by_date_ops.map { |e| e[1] }
    @cat_dates = category_by_date_ops.map { |e| e[0] }
  end
end
