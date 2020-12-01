class GildedRose
  MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each { |item| update_single_item(item) }
  end
  
  def update_single_item(item)
    
    if item.name == "Aged Brie"
      item.quality += 1 if item.quality < MAX_QUALITY
      item.quality += 1 if (item.sell_in < 0 && item.quality < MAX_QUALITY)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      item.quality += 1 if item.quality < MAX_QUALITY
      item.quality += 1 if (item.sell_in < 11 && item.quality < MAX_QUALITY)
      item.quality += 1 if (item.sell_in < 6 && item.quality < MAX_QUALITY)     
      item.quality = 0 if item.sell_in < 0
    elsif item.name == "Conjured Mana Cake"
      item.quality -= 2 if item.quality > 1
      item.quality -= 2 if (item.sell_in < 0 && item.quality > 1)
    elsif item.name == "Sulfuras, Hand of Ragnaros"
      item.quality = item.quality
    else
      item.quality -= 1 if item.quality > 0
      item.quality -= 1 if (item.sell_in < 0 && item.quality > 0)
    end
    
    item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
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
