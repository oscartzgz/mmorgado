class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order

  def index
    
  end

  def show
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
