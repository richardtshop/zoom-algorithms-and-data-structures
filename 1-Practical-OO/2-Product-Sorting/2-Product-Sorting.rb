# frozen_string_literal: true

class ProductSorter
  attr_reader :products

  def initialize(products:)
    @products = products.map { |product_group| create_product(product_group) }
    # @products = products
  end

  def sort_products
    @products.sort
  end

  def sort_products!
    @products.sort!
  end

  def to_s
    products.map(&:title)
  end

  private

  def create_product(product)
    Product.new(product_info: product.split(','))
  end
end

class Product
  include Comparable
  attr_reader :title, :popularity, :price

  def initialize(product_info: ['', '', ''])
    @title = product_info.first
    @popularity = product_info[1].to_i
    @price = product_info.last.to_i
  end

  def <=>(other)
    return other.popularity <=> popularity unless popularity == other.popularity

    price <=> other.price
  end
end

products = [
  'Selfie Stick,98,29',
  'iPhone Case,90,15',
  'Fire TV Stick,48,49',
  'Wyze Cam,48,25',
  'Water Filter,56,49',
  'Blue Light Blocking Glasses,90,16',
  'Ice Maker,47,119',
  'Video Doorbell,47,199',
  'AA Batteries,64,12',
  'Disinfecting Wipes,37,12',
  'Baseball Cards,73,16',
  'Winter Gloves,32,112',
  'Microphone,44,22',
  'Pet Kennel,5,24',
  'Jenga Classic Game,100,7',
  'Ink Cartridges,88,45',
  'Instant Pot,98,59',
  'Hoze Nozzle,74,26',
  'Gift Card,45,25',
  'Keyboard,82,19'
]

products_to_sort = ProductSorter.new(products: products)
# products_to_sort = ProductSorter.new(products: products.map { |product_group| Product.new(product_info: product_group.split(',')) })
products_to_sort.sort_products!
puts products_to_sort.to_s
