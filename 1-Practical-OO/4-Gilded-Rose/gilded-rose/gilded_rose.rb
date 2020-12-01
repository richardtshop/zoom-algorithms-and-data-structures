class GildedRose
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each { |item| update_single_item(item) }
  end
  
  def update_single_item(item)
    case item.name
    when "Backstage passes to a TAFKAL80ETC concert"
      item.quality += 1
      item.quality += 1 if item.sell_in < 11
      item.quality += 1 if item.sell_in < 6 
      item.quality = 0 if item.sell_in < 0
    when "Aged Brie"
      item.quality += adjust_item_quality(item, 2, 1)
    when "Conjured Mana Cake"
      item.quality += adjust_item_quality(item, -4, -2)
    when "Sulfuras, Hand of Ragnaros"
      item.quality += adjust_item_quality(item, 0, 0)
    else
      item.quality += adjust_item_quality(item, -2, -1)
    end
    
    unless item.name == "Sulfuras, Hand of Ragnaros"
      item.sell_in -= 1 
      item.quality = final_adjusted_quality(item)
    end
  end
  
  private
  
  def adjust_item_quality(item, out_of_date_change, in_date_change)
    item.sell_in < 0 ? out_of_date_change : in_date_change
  end
  
  def final_adjusted_quality(item)
    return MAX_QUALITY if item.quality > MAX_QUALITY
    return MIN_QUALITY if item.quality < MIN_QUALITY
    
    item.quality
  end
  
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
