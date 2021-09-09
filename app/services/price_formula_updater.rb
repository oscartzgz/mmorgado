# Call on creation of new ProductBrand
# or in creation of new provider to update
# the price formula for all brands if providers need it
class PriceFormulaUpdater
  DEFAULT_FORMULAS = {
                    price_cost: "21+31+10",
                    general:    "21+31+10"}

  def initialize(objects)
    @objects = objects.respond_to?(:each) ? objects : [objects]
    @object_class = @objects.first.class
  end

  def self.update_all_brands_prices
    DEFAULT_FORMULAS.each do |kind, formula|
      ProductBrand.all.each do |product_brand|
        Provider.all.each do |provider|
          price_formula = provider.price_formulas.create(
            name: kind,
            formula: formula,
            priceable_id: product_brand.id,
            priceable_type: ProductBrand.to_s
          )
          puts "ERROR: #{price_formula.errors.full_messages}" if price_formula.errors
        end
      end
    end
  end

  def update
    if @object_class == ProductBrand
      create_product_brands_prices
    elsif @object_class == Product
      create_product_prices(@objects.first)
    else
      "ERROR: #{@object_class} isn't priceable"
    end
  end

  # Create product brand price for all providers
  def create_product_brands_prices
    DEFAULT_FORMULAS.each do |kind, formula|
      @objects.each do |product_brand|
        Provider.all.each do |provider|
          price_formula = provider.price_formulas.create(
            name: kind,
            formula: formula,
            priceable_id: product_brand.id,
            priceable_type: @object_class.to_s
          )
          puts "ERROR: #{price_formula.errors.full_messages}" if price_formula.errors
        end
      end
    end
  end

  def create_product_price(product)
    DEFAULT_FORMULAS.each do |kind, formula|

      price_formula = product.provider.price_formulas.create(
        name: kind,
        formula: formula,
        priceable_id: product.id,
        priceable_type: @object_class.to_s
      )
      puts "ERROR: #{price_formula.errors.full_messages}" if price_formula.errors
    end
  end

end
