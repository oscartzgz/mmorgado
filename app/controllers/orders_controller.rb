class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %w(show toogle_delivered)

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
  end

  def toogle_delivered
    @order.update(delivered: !@order.delivered)
    render :show
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
