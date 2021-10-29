class Api::V1::ClientsController < ApplicationController
  before_action :set_client, only: %w(show)
  
  def index
    clients = Client.search(params)
    render json: clients, status: :ok   
  end

  def show
    render json: @client, status: :ok
  end

  private
  
  def set_client
    @client = Client.find(params[:id])
  end
end
