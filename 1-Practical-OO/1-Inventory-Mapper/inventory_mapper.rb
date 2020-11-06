class Inventory
  PRODUCT_PARTS = {
    'a' => { parent: 'Shelf', sub: 'unit' },
    'b' => { parent: 'Stool', sub: 'top' },
    'c' => { parent: 'Stool', sub: 'legs' },
    'd' => { parent: 'Table', sub: 'top' },
    'e' => { parent: 'Table', sub: 'legs' }
  }.freeze

  attr_reader :parts, :product_output, :current_parts

  def initialize(parts_string)
    @parts = parts_string.split('')
    @product_output = { 'Shelf' => 0, 'Stool' => 0, 'Table' => 0 }
    @current_parts = {
      'Shelf' => { 'unit' => 0 },
      'Stool' => { 'top' => 0, 'legs' => 0 },
      'Table' => { 'top' => 0, 'legs' => 0 }
    }
  end

  def map_parts
    parts.map do |part_id|
      next if PRODUCT_PARTS[part_id].nil?

      parent_part = PRODUCT_PARTS[part_id][:parent]
      sub_part = PRODUCT_PARTS[part_id][:sub]
      @current_parts[parent_part][sub_part] += 1
    end

    current_parts.each_pair do |key, value|
      @product_output[key] = value['unit'] if key == 'Shelf'
      add_product(value, key, 1, 3) if key == 'Stool'
      add_product(value, key, 1, 4) if key == 'Table'
    end
    @product_output
  end

  private

  def add_product_to_output(value, key, top, legs)
    while value['top'] >= top && value['legs'] >= legs 
      @product_output[key] += top
      value['legs'] -= legs
      value['top'] -= top
    end
  end
end

inventory1 = Inventory.new('abccc')
puts inventory1.map_parts
inventory2 = Inventory.new('beceadee')
puts inventory2.map_parts
inventory3 = Inventory.new('eebeedebaceeceedeceacee')
puts inventory3.map_parts
inventory4 = Inventory.new('zabc')
puts inventory4.map_parts
inventory5 = Inventory.new('deeedeee')
puts inventory5.map_parts
