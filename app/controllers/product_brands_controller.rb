class ProductBrandsController < ApplicationController
  before_action :set_product_brand, only: %i[ show edit update destroy ]

  # GET /product_brands or /product_brands.json
  def index
    @product_brands = ProductBrand.all
  end

  # GET /product_brands/1 or /product_brands/1.json
  def show
  end

  # GET /product_brands/new
  def new
    @product_brand = ProductBrand.new
  end

  # GET /product_brands/1/edit
  def edit
  end

  # POST /product_brands or /product_brands.json
  def create
    @product_brand = ProductBrand.new(product_brand_params)

    respond_to do |format|
      if @product_brand.save
        format.html { redirect_to @product_brand, notice: "Product brand was successfully created." }
        format.json { render :show, status: :created, location: @product_brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_brands/1 or /product_brands/1.json
  def update
    respond_to do |format|
      if @product_brand.update(product_brand_params)
        format.html { redirect_to @product_brand, notice: "Product brand was successfully updated." }
        format.json { render :show, status: :ok, location: @product_brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_brands/1 or /product_brands/1.json
  def destroy
    @product_brand.destroy
    respond_to do |format|
      format.html { redirect_to product_brands_url, notice: "Product brand was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_brand
      @product_brand = ProductBrand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_brand_params
      params.require(:product_brand).permit(:name, :active)
    end
end
