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
    byebug
    @order.cashier_id = current_user.id
    # @order.orderable_type = 'Product' if @order.kind == 0
    
    if @order.save
      render json: @order, status: :created
    else
      render json: {errors: @order.errors.full_messages}, status: :unprocessable_entity 
    end
  end

  private
  
  def order_params
    params.require(:order).permit(:code, :payment_type, :client_id, :seller_id, :cashier_id,
                                  order_items_attributes: [
                                    :id, :code, :name, :quantity, :price, :kind,
                                    :payment_type, :order_id, :orderable_id, :orderable_type,
                                    :_destroy])
  end

  # def set_client
  #   @client = Client.find(params[:id])
  # end
end
