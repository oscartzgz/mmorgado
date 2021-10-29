class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %w(show)

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
