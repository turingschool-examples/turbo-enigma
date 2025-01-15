require 'rspec'
require 'pry'
require './lib/food_truck'
require './lib/item'

RSpec.describe FoodTruck do
  before(:each) do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  describe 'initialize' do
    it 'exists' do
      expect(@food_truck).to be_a FoodTruck
      expect(@food_truck.name).to eq("Rocky Mountain Pies")
      expect(@food_truck.inventory).to eq({})
    end
  end

  describe 'stock and stocking' do
    it 'can check stock and add to stock/restock' do
      expect(@food_truck.check_stock(@item1)).to eq(0)

      @food_truck.stock(@item1, 30)

      expect(@food_truck.inventory).to eq({@item1 => 30})
      expect(@food_truck.check_stock(@item1)).to eq(30)

      @food_truck.stock(@item1, 25)

      expect(@food_truck.check_stock(@item1)).to eq(55)

      @food_truck.stock(@item2, 12)

      expect(@food_truck.inventory).to eq({@item1 => 55, @item2 => 12})
    end
  end

  describe 'can check potential revenue' do
    it'checks potential revenue' do
      @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      @food_truck3 = FoodTruck.new("Palisade Peach Shack")
      @item10 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
      @item20 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
      @item30 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item40 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

      @food_truck1.stock(@item10, 35)
      @food_truck1.stock(@item20, 7)

      @food_truck2.stock(@item40, 50)
      @food_truck2.stock(@item30, 25)

      @food_truck3.stock(@item10, 65)

      expect(@food_truck1.potential_revenue).to eq(148.75)
      expect(@food_truck2.potential_revenue).to eq(345.00)
      expect(@food_truck3.potential_revenue).to eq(243.75)
    end
  end
end