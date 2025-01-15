require './lib/item'
require './lib/food_truck'
require 'pry'

RSpec.describe FoodTruck do
  before(:each) do
    @foodtruck = FoodTruck.new("Rocky Mountain Pies")
  end

  it 'exists and has attributes' do

    expect(@foodtruck).to be_an_instance_of(FoodTruck)
    expect(@foodtruck.name).to eq("Rocky Mountain Pies")
    expect(@foodtruck.inventory).to eq({})
  end

  it 'checks default item stock' do

    item = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})

    expect(@foodtruck.check_stock(item)).to eq(0)
  end

  it 'stocks items and updates inventory' do
  
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: "$2.50"})

    @foodtruck.stock(item1, 30)

    expect(@foodtruck.inventory).to eq({item1 => 30})

    @foodtruck.stock(item1, 25)

    expect(@foodtruck.inventory).to eq({item1 => 55})

    @foodtruck.stock(item2, 12)

    expect(@foodtruck.inventory).to eq({item1 => 55, item2 => 12})
  end

  

end