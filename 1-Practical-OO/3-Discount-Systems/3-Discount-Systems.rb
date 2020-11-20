# Discounter module to include in Product class
module Discounter
  
  def self.percentage_off(total_price:, percentage_discount:, quantity:)
    return 0 unless quantity  > 1
    
    total_price - (total_price * ((100 - percentage_discount)) / 100)
  end
  
  def self.buy_one_get_one_free(total_price:, quantity:)
    return 0 unless quantity  > 1
    
    single_item_price = total_price / quantity
    remainder = quantity % 2 # check if odd/even
    free_item_count = (quantity - remainder) / 2
    single_item_price * free_item_count
  end
end

# Checkout class

class Checkout
  attr_reader :products, :subtotal, :total

  def initialize(products: [])
    @products = products.map { |product| ProductGroup.new(product_details: product) }
    @subtotal = calculate_subtotal
    @total = calculate_total
  end

  def to_dollars_string
    "Total: $#{format_from_cents(total)} (Savings: $#{format_from_cents(calculate_savings)})"
  end
  
  private

  def calculate_subtotal
    products.reduce(0) { |sum, product| sum + product.subtotal }
  end
  
  def calculate_total
    products.reduce(0) { |sum, product| sum + product.total }  
  end
  
  def calculate_savings
    subtotal - total
  end
  
  def format_from_cents(cents)
    '%.2f' % (cents * 1.0/ 100)
  end
end

# Product group class

class ProductGroup
  include Discounter
  
  PRICES = {
    grapes: 500,
    apples: 300,
    peaches: 700
  }.freeze

  attr_reader :type, :quantity, :subtotal, :total

  def initialize(product_details: [])
    @type, @quantity = product_details
    @subtotal = PRICES[type.to_sym] * quantity
    @total = get_total
  end
  
  private
  
  def get_total
    return subtotal if quantity.zero?
    
    subtotal - discount_amount
  end

  def discount_amount # calculate discount based on product type and quantity
    if type == 'apples'
      Discounter.percentage_off(total_price: subtotal, percentage_discount: 20,  quantity: quantity)
    elsif type == 'grapes'
      Discounter.buy_one_get_one_free(total_price: subtotal, quantity: quantity)
    else 
      0
    end
  end
end



checkout1 = Checkout.new(products: [['grapes', 1], ['apples', 0], ['peaches', 1]]) # output => 12
puts checkout1.to_dollars_string
checkout2 = Checkout.new(products: [['grapes', 1], ['apples', 1], ['peaches', 1]]) # output => 15
puts checkout2.to_dollars_string
checkout3 = Checkout.new(products: [['grapes', 2], ['apples', 2], ['peaches', 1]]) # output => 16.8
puts checkout3.to_dollars_string
checkout4 = Checkout.new(products: [['grapes', 3], ['apples', 5], ['peaches', 2]]) # output => 36
puts checkout4.to_dollars_string
checkout5 = Checkout.new(products: [['peaches', 7], ['grapes', 7], ['apples', 7]]) # output => 85.8
puts checkout5.to_dollars_string