class Checkout
  attr_reader :products, :subtotal, :total

  def initialize(products: [])
    @products = products.map { |product| Product.new(product_details: product) }
    @subtotal = calculate_subtotal
    @total = calculate_total
  end

  private

  def calculate_subtotal
    products.reduce(0) { |sum, product| sum + product.subtotal }
  end
  
  def calculate_total
    products.reduce(0) { |sum, product| sum + product.total }  
  end
end

class Product
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

  def to_s
    "#{quantity} #{type}: $#{price / 100}"
  end

  private
  
  def get_total
    return subtotal if quantity.zero?
    subtotal - get_discount_amount
  end

  def get_discount_amount # calculate discount based on product type and quantity
    if type == 'apples'
      Discounter.percentage_off(total_price: subtotal, percentage_discount: 20)
    elsif type == 'grapes'
      Discounter.bogof(total_price: subtotal, quantity: quantity)
    else 
      0
    end
  end
end

# Abstract class for calculating discounts
class Discounter
  
  
  def self.percentage_off(total_price:, percentage_discount:)
    total_price - (total_price * ((100 - percentage_discount)) / 100)
  end
  
  def self.bogof(total_price:, quantity:)
    single_item_price = total_price / quantity
    if quantity > 1
      remainder = quantity % 2 # check if odd/even
      free_item_count = (quantity - remainder) / 2
      discount = single_item_price * free_item_count
    else 
      discount = 0
    end
  end
end


# checkout1 = Checkout.new(products: [['grapes', 1], ['apples', 0], ['peaches', 1]]) # output => 12
# puts checkout1.total
checkout2 = Checkout.new(products: [['grapes', 1], ['apples', 1], ['peaches', 1]]) # output => 15
puts checkout2.total
# checkout3 = Checkout.new(products: [['grapes', 2], ['apples', 2], ['peaches', 1]]) # output => 16.8
# puts checkout3.total
# checkout4 = Checkout.new(products: [['grapes', 3], ['apples', 5], ['peaches', 2]]) # output => 36
# puts checkout4.total
# checkout5 = Checkout.new(products: [['peaches', 7], ['grapes', 7], ['apples', 7]]) # output => 85.8
# puts checkout5.total