# Call on creation of new ProductBrand
# or in creation of new provider to update
# the price formula for all brands if providers need it
class PriceFormulaUpdater
  DEFAULT_FORMULAS = {
                    price_cost: "21+31+10",
                    general: "21+31+10"}
  
  def initialize(providers = Provider.all)
    @providers = providers.is_a?(Provider) ? [providers] : providers
  end

  def update
    create_product_brand_prices
  end

  def create_product_brand_prices
    DEFAULT_FORMULAS.each do |kind, formula|
      ProductBrand.all.each do |product_brand|
        @providers.each do |provider|
          price_formula = provider.price_formulas.create(
            name: kind,
            formula: formula,
            priceable_id: product_brand.id,
            priceable_type: product_brand.class.to_s
          )
          puts "ERROR: #{price_formula.errors.full_messages}" if price_formula.errors
        end
      end
    end
  end

end