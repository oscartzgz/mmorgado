class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %w(show)
  
  def index
    products = Product.search(params)
    render json: products, status: :ok
  end

  def show
    render json: @product, status: :ok
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
