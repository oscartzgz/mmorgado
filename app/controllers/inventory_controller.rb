class InventoryController < ApplicationController
  def index
    @products = Product.all
  end
end
