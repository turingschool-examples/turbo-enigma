require 'rspec'
require './lib/item'
require './lib/food_truck'
require 'pry'

describe FoodTruck do
  before(:each) do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: '$3.75'})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  it 'exists' do
    expect(@food_truck).to be_a(FoodTruck)
  end

  it 'has a name' do
    expect(@food_truck.name).to eq("Rocky Mountain Pies")
  end

  it 'has an inventory' do
    expect(@food_truck.inventory).to eq({})
  end

  it 'can check the stock of an item' do
    expect(@food_truck.check_stock(@item1)).to eq(0)
  end

  it 'can stock an item' do
    @food_truck.stock(@item1, 30)
    expect(@food_truck.check_stock(@item1)).to eq(30)
  end

  it 'can add to the existing stock of an item' do
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)
    expect(@food_truck.check_stock(@item1)).to eq(55)

  end

  it 'can stock and display multiple items in its inventory' do
    @food_truck.stock(@item1, 55)
    @food_truck.stock(@item2, 12)
    expect(@food_truck.inventory).to eq({@item1 => 55, @item2 => 12})
  end

  it 'can display potential revenue' do
    @food_truck.stock(@item1, 55)
    @food_truck.stock(@item2, 12)
    expect(@food_truck.potential_revenue).to eq(236.25)
  end
end