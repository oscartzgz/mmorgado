class InventoryController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
end
