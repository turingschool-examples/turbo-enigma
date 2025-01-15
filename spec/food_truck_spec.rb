require './lib/item.rb'
require './lib/food_truck.rb'
require 'pry'

RSpec.describe FoodTruck do
  before(:each) do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  it 'exists' do
    expect(@food_truck).to be_a(FoodTruck)
  end

  it 'has a company name and starts with empty inventory' do
    expect(@food_truck.name).to eq("Rocky Mountain Pies")
    expect(@food_truck.inventory).to eq({})
  end

  it 'can stock items, and check stock in inventory' do
    expect(@food_truck.check_stock(@item1)).to eq(0)

    @food_truck.stock(@item1, 30)

    expect(@food_truck.inventory).to eq({@item1 => 30})
    expect(@food_truck.check_stock(@item1)).to eq(30)

    @food_truck.stock(@item1, 25)
    @food_truck.stock(@item2, 12)

    expect(@food_truck.inventory).to eq({@item1 => 55, @item2 => 12})
    expect(@food_truck.check_stock(@item2)).to eq(12)
  end

  it 'can determine potential revenue based on current inventory' do
    @food_truck.stock(@item1, 10)
    @food_truck.stock(@item2, 4)

    expect(@food_truck.potential_revenue()).to eq(47.50)

  end

  

end