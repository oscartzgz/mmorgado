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

  def self.update_all_products_prices
    DEFAULT_FORMULAS.each do |kind, formula|
      Product.all.each do |product|
        Provider.all.each do |provider|
          price_formula = provider.price_formulas.create(
            name: kind,
            formula: formula,
            priceable_id: product.id,
            priceable_type: Product.to_s
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
        # Formula brand should be created for all distributors providers
        # and for only for a maker provider that match in the name
        formulas_attributes = Provider.where(kind: 'Distribuidor').map do |provider|
          {
            name: kind,
            formula: formula,
            provider_id: provider.id,
            priceable_id: product_brand.id,
            priceable_type: @object_class.to_s,
            created_at: Time.now,
            updated_at: Time.now
          }
        end
        PriceFormula.upsert_all(formulas_attributes)

        Provider.where('lower(full_name) = ?', product_brand.name.downcase).each do |provider|
          price_formula = provider.price_formulas.find_or_create_by(
            name: kind,
            formula: formula,
            priceable_id: product_brand.id,
            priceable_type: @object_class.to_s
          )
        end

      end
    end
  end

  def create_product_prices(product)
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
