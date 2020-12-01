# test different types of items for each test

require 'minitest/autorun'
require_relative 'gilded_rose'

class  GildedRoseTest < Minitest::Test

  def test_normal_items_before_sell_by_date_degrade_by_one
    quality = 10
    item = Item.new("foo", 1, quality)
    GildedRose.new([item]).update_quality()
    assert_equal(quality - 1, item.quality)  
  end
  
  def test_items_past_sell_by_date_degrade_in_quality_twice_as_fast
    quality = 10
    item = Item.new("foo", -1, quality)
    GildedRose.new([item]).update_quality()
    assert_equal(quality - 2, item.quality)  
  end
  
  def test_item_quality_cannot_decrease_below_zero
    quality = 0
    item = Item.new("foo", 0, quality)
    GildedRose.new([item]).update_quality()
    assert_equal(0, item.quality)  
  end
  
  def test_aged_brie_increase_in_quality_as_it_ages
    quality = 10
    brie = Item.new("Aged Brie", 0, quality)
    GildedRose.new([brie]).update_quality()
    assert(brie.quality > quality)
  end
  
  def test_normal_item_quality_cannot_exceed_fifty
    quality = 50
    brie = Item.new("Aged Brie", 0, quality)
    GildedRose.new([brie]).update_quality()
    assert(brie.quality <= quality)
  end
  
  def test_sulfaras_quality_does_not_decrease
    quality = 80
    sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 10, quality)
    GildedRose.new([sulfuras]).update_quality()
    assert_equal(quality, sulfuras.quality)
  end
  
  
  def test_sulfaras_sell_by_date_does_not_decrease
    sell_in = 10
    sulfuras = Item.new("Sulfuras, Hand of Ragnaros", sell_in, 10)
    GildedRose.new([sulfuras]).update_quality()
    assert_equal(sell_in, sulfuras.sell_in)
  end
  
  def test_backstage_passes_increase_in_quality_by_one_if_sell_in_greater_than_ten
    quality = 10
    backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", 11, quality)
    GildedRose.new([backstage]).update_quality()
    assert_equal(quality + 1, backstage.quality)
  end
  
  def test_backstage_passes_increase_in_quality_by_two_if_sell_in_between_ten_and_five
    quality = 10
    backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", 6, quality)
    GildedRose.new([backstage]).update_quality()
    assert_equal(quality + 2, backstage.quality)
  end
  
  def test_backstage_passes_increase_in_quality_by_three_if_sell_in_between_five_and_one
    quality = 10
    backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", 4, quality)
    GildedRose.new([backstage]).update_quality()
    assert_equal(quality + 3, backstage.quality)
  end
  
  def test_backstage_passes_is_zero_if_sell_by_date_has_passed
    quality = 4
    backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, quality)
    GildedRose.new([backstage]).update_quality()
    assert_equal(0, backstage.quality)
  end
  
  def test_conjured_items_degrade_by_two_each_day_before_sell_by_date
    quality = 10
    conjured = Item.new("Conjured Mana Cake", 11, quality)
    GildedRose.new([conjured]).update_quality()
    assert_equal(quality - 2, conjured.quality)
  end
  
  
  def test_conjured_items_degrade_by_four_each_day_after_sell_by_date
    quality = 10
    conjured = Item.new("Conjured Mana Cake", -1, quality)
    GildedRose.new([conjured]).update_quality()
    assert_equal(quality - 4, conjured.quality)
  end
  
  
end