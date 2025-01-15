require './lib/food_truck'
require './lib/item'
require './lib/event'
require 'pry'

describe Event do
  before :each do
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@event).to be_a(Event)
    end
  end

  describe '#add_food_truck' do
    it 'adds a food truck to the food_trucks array' do
      expect(@event.food_trucks.count).to eq(3)
    end
  end

  describe '#food_truck_names' do
    it 'returns an array of food truck names' do
      expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#food_trucks_that_sell(item)' do
    it 'returns food trucks that sell specified item' do
      @food_truck1.stock(@item1, 35)
      expect(@event.food_trucks_that_sell(@item1).count).to eq(1)
      @food_truck3.stock(@item1, 65)
      expect(@event.food_trucks_that_sell(@item1).count).to eq(2)
      expect(@event.food_trucks_that_sell(@item2).count).to eq(0)
      @food_truck1.stock(@item2, 7)
      expect(@event.food_trucks_that_sell(@item2).count).to eq(1)
    end
  end

  describe '#sorted_item_list' do
    it 'returns an alphabetical array of all foodtruck item names' do
      @food_truck1.stock(@item1, 35)
      expect(@event.sorted_item_list).to eq(['Peach Pie (Slice)'])
      @food_truck1.stock(@item2, 7)
      expect(@event.sorted_item_list).to eq(['Apple Pie (Slice)', 'Peach Pie (Slice)'])
      @food_truck3.stock(@item1, 65)
      expect(@event.sorted_item_list).to eq(['Apple Pie (Slice)', 'Peach Pie (Slice)'])
      @food_truck3.stock(@item3, 45)
      expect(@event.sorted_item_list).to eq(['Apple Pie (Slice)', 'Peach Pie (Slice)', 'Peach-Raspberry Nice Cream'])
    end
  end

  describe '#overstocked_items' do
    it 'returns an array of item objects sold by 2 or more food trucks and have quantity over 50' do
      @food_truck1.stock(@item1, 35)
      expect(@event.overstocked_items).to eq([])
      @food_truck2.stock(@item1, 5)
      expect(@event.overstocked_items).to eq([])
      @food_truck2.stock(@item1, 15)
      expect(@event.overstocked_items.count).to eq(1)
      @food_truck3.stock(@item3, 55)
      expect(@event.overstocked_items.count).to eq(1)
      @food_truck1.stock(@item3, 10)
      expect(@event.overstocked_items.count).to eq(2)
    end
  end
end