class Api::V1::ProvidersController < ApplicationController
  def index
    providers = Provider.search(params)
    render json: providers, status: :ok
  end
end
