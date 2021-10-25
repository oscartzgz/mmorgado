class Providers::PurchasesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @q = Provider.ransack(params[:q])
    @providers = @q.result(distinct: true)
  end
end
