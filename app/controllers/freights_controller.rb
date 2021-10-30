class FreightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_freight, only: %i[ show edit update destroy ]

  # GET /freights or /freights.json
  def index
    @q = Freight.ransack(params[:q])
    @freights = @q.result(distinct: true)
  end

  # GET /freights/1 or /freights/1.json
  def show
  end

  # GET /freights/new
  # def new
  #   @freight = Freight.new
  # end

  # GET /freights/1/edit
  # def edit
  # end

  # POST /freights or /freights.json
  # def create
  #   @freight = Freight.new(freight_params)
  #   respond_to do |format|
  #     if @freight.save
  #       format.html { redirect_to @freight, notice: "Freight was successfully created." }
  #       format.json { render :show, status: :created, location: @freight }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @freight.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /freights/1 or /freights/1.json
  def update
    respond_to do |format|
      if @freight.update(freight_params)
        format.html { redirect_to @freight, notice: "Freight was successfully updated." }
        format.json { render :show, status: :ok, location: @freight }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @freight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /freights/1 or /freights/1.json
  def destroy
    @freight.destroy
    respond_to do |format|
      format.html { redirect_to freights_url, notice: "Freight was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_freight
      @freight = Freight.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def freight_params
      params.require(:freight).permit(:client_id, :kind, :import, :order_id, :user_id)
    end
end
