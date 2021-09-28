class Api::V1::ClientsController < ApplicationController
  def index
    clients = Client.search(params)
    render json: clients, status: :ok   
  end
end
