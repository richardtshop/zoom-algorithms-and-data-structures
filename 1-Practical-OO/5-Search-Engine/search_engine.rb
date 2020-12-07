require 'json'

class Inventory
  attr_reader :products, :index_hash
    
  def initialize(hash_array)
    @products = hash_array
    @index_hash = {}
    hash_array.each do |product|
     index_hash[product["id"]] = product 
    end
  end
  
  def get_products_by_id(id_array)
    return -1 if id_array.nil?
    id_array.map { |index| get_product_by_id(index) } 
  end
  
  def get_product_by_id(id)
    index_hash[id]
  end
end

class WordIndex
  attr_reader :index
  
  def initialize()
    @index = {}
  end 
  
  def add_word_to_index(product)
    product["name"].split.each do |word|
      index[word.downcase] ||= []
      index[word.downcase] << product["id"] 
    end
  end
  
  def search(search_term:, condition: "and")
    search_term.downcase!
    search_terms = search_term.split(" ")
    total_terms = search_terms.size
    return get_word_indices(search_term) if total_terms == 1
    
    combined_results = search_terms
      .map { |term| get_word_indices(term) }
      .flatten
      .sort
    
    case condition
    when "and"
      results_count = {}
      combined_results.each do |index|
        results_count[index] ||= 0
        results_count[index] += 1
      end
      results_count
        .filter! { |key, value| value == total_terms}
        .keys
    when "or"
      combined_results.uniq
    end  
    
  end 
  
  private
  
  def get_word_indices(word)
    index[word].sort
  end
end

data = JSON.parse(File.read('./here.json'))
inventory = Inventory.new(data)
word_index = WordIndex.new

inventory.products.each { |product| word_index.add_word_to_index(product) }

keyboard_search = word_index.search(search_term: "keyboard")
steel_search = word_index.search(search_term: "steel")
and_search_results = word_index.search(search_term: "KEYBOARD steel", condition: "and")
or_search_results = word_index.search(search_term: "KEYBOARD steel", condition: "or")

print "#{keyboard_search.size} results: #{keyboard_search}\n" # => 12 results: [18, 50, 53, 58, 61, 73, 76, 85, 88, 103, 113, 120]
print "#{steel_search.size} results: #{steel_search}\n" # => 10 results: [41, 58, 80, 87, 97, 99, 115, 117, 120, 121]
print "#{and_search_results.size} results: #{and_search_results}\n" # => 2 results: [58, 120]
print "#{or_search_results.size} results: #{or_search_results}\n" # => 20 results: [18, 41, 50, 53, 58, 61, 73, 76, 80, 85, 87, 88, 97, 99, 103, 113, 115, 117, 120, 121]

puts keyboard_search.concat(steel_search).uniq.sort == or_search_results # true (checking or results match uniq individual searches)
# puts products.get_products_by_id(steel_search)