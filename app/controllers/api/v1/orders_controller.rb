class Api::V1::OrdersController < ApplicationController
  # before_action :set_order, only: %w(show)
  
  # def index
  #   order = Order.search(params)
  #   render json: orders, status: :ok   
  # end

  # def show
  #   render json: @client, status: :ok
  # end

  def create
    @order = Order.new(order_params)
    @order.cashier_id = current_user.id
    
    if @order.save
      render json: @order, status: :created
    else
      render json: {errors: @order.errors.full_messages}, status: :unprocessable_entity 
    end
  end

  private
  
  def order_params
    params.require(:order).permit(:code, :payment_type, :client_id, :seller_id, :cashier_id)
  end

  # def set_client
  #   @client = Client.find(params[:id])
  # end
end
