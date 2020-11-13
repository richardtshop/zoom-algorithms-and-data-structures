# frozen_string_literal: true

class ProductSorter
  attr_reader :products

  def initialize(products: [])
    @products = products.map { |product| product.split(',') }
  end

  def sort_products
    @products.sort! do |a, b|
      if b[1] == a[1]
        a[2].to_i <=> b[2].to_i
      else
        b[1].to_i <=> a[1].to_i
      end
    end
  end

  def to_s
    products.map(&:first)
  end
end

products_to_sort = ProductSorter.new(
  products: ['Selfie Stick,98,29',
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
             'Keyboard,82,19']
)

puts products_to_sort.to_s

products_to_sort.sort_products
puts '============='
puts products_to_sort.to_s
