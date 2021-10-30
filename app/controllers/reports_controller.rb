class ReportsController < ApplicationController
  def index
    case params[:report] || nil
    when 'price_list'           then price_list
    when 'price_list_detailed'  then price_list_detailed
    when 'stock_list'           then stock_list
    when 'stock_list_detailed'  then stock_list_detailed
    when 'daily_sales'          then daily_sales
    when 'daily_sales_cash'     then daily_sales_cash
    when 'daily_sales_aparts'   then daily_sales_aparts
    else
      @report_type = nil
    end
  end

  private

  def price_list
    @report_type = 'price_list'
    @report_data = Product.all
  end

  def price_list_detailed
    @report_type = 'price_list_detailed'
    @report_data = Product.all
  end

  def stock_list
    @report_type = 'stock_list'
    @report_data = Product.all
  end

  def stock_list_detailed
    @report_type = 'stock_list_detailed'
    @report_data = Product.all
  end

  def daily_sales
    @report_type = 'daily_sales'
    @report_data = OrderItem.all.where(kind: :product)
  end

  def daily_sales_cash
    @report_type = 'daily_sales_cash'
    @report_data = OrderItem.all.where(kind: :product)
  end

  def daily_sales_aparts
    @report_type = 'daily_sales_aparts'
    @report_data = OrderItem.all.where(kind: :product)
  end
  
end
