class PriceFormulasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_price_formula, only: %i[ show edit update destroy toggle]

  # GET /price_formulas or /price_formulas.json
  def index
    @priceable_target = params[:priceable_target]&.to_sym || :brands
    @q = PriceFormula.ransack(params[:q])
    @price_formulas = @q.result(distinct: true)

    @provider = @q.base.conditions.blank? ? 
                nil
                : 
                Provider.
                  includes(:products, :price_formulas).
                  find(@q.base.conditions.dig(0).values.dig(0).value.to_i)
   
    @price_formulas_by_brand = @price_formulas #.where(priceable_type: 'Brand')
  end

  # GET /price_formulas/1 or /price_formulas/1.json
  def show; end

  # GET /price_formulas/new
  def new
    @price_formula = 
      PriceFormula.new(
          provider_id: params[:provider_id],
          priceable_type: params[:model_type])

    @provider = Provider.find(@price_formula.provider_id)
  end

  # GET /price_formulas/1/edit
  def edit; end

  # POST /price_formulas or /price_formulas.json
  def create
    @price_formula = PriceFormula.new(price_formula_params)
    @provider = Provider.find(@price_formula.provider_id)

    respond_to do |format|
      if @price_formula.save
        format.html { redirect_to @price_formula, notice: "Price formula was successfully created." }
        format.json { render :show, status: :created, location: @price_formula }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @price_formula.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_formulas/1 or /price_formulas/1.json
  def update
    respond_to do |format|
      if @price_formula.update(price_formula_params)
        format.html { redirect_to @price_formula, notice: "Price formula was successfully updated." }
        format.json { render :show, status: :ok, location: @price_formula }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @price_formula.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    head 200 if @price_formula.toggle!(:enable)
  end

  # DELETE /price_formulas/1 or /price_formulas/1.json
  def destroy
    @price_formula.destroy
    respond_to do |format|
      format.html { redirect_to price_formulas_url, notice: "Price formula was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_formula
      @price_formula = PriceFormula.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def price_formula_params
      params.require(:price_formula).permit(:enable, :formula, :priceable_type, :priceable_id, :provider_id)
    end
end
