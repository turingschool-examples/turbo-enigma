require 'spec_helper'

RSpec.describe FoodTruck do
  before :each do
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  it 'exists and has attributes' do
    expect(@food_truck).to be_an_instance_of(FoodTruck)
    expect(@food_truck.name).to eq("Rocky Mountain Pies")
    expect(@food_truck.inventory).to eq({})
  end

  it 'can check stock of an item' do
    expect(@food_truck.check_stock(@item1)).to eq(0)
  end

  it 'can stock items' do
    @food_truck.stock(@item1, 30)
    expect(@food_truck.inventory).to eq({@item1 => 30})
    expect(@food_truck.check_stock(@item1)).to eq(30)

    @food_truck.stock(@item1, 25)
    expect(@food_truck.check_stock(@item1)).to eq(55)

    @food_truck.stock(@item2, 12)
    expect(@food_truck.inventory).to eq({@item1 => 55, @item2 => 12})
  end

  it 'can calculate potential revenue' do
    @food_truck.stock(@item1, 35)
    @food_truck.stock(@item2, 7)
    expect(@food_truck.potential_revenue).to eq(148.75)
  end
#edge cases
  it 'can stock the same item multiple times' do
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 20)
    expect(@food_truck.check_stock(@item1)).to eq(50)
  end

  it 'returns 0 for items not stocked' do
    expect(@food_truck.check_stock(@item3)).to eq(0)
  end

  it 'calculates potential revenue with empty inventory' do
    expect(@food_truck.potential_revenue).to eq(0)
  end
end
