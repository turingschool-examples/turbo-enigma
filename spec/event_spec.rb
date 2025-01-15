require 'rspec'
require './lib/item'
require './lib/food_truck'
require './lib/event'
require 'time'

describe Event do
  before(:each) do
    @event = Event.new("South Pearl Street Farmers Market")

    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)

    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)

    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @food_truck3.stock(@item1, 65)
  end

  it 'exists' do
    expect(@event).to be_a(Event)
  end

  it 'has a name' do
    expect(@event.name).to eq("South Pearl Street Farmers Market")
  end

  it 'has a collection of food trucks' do
    expect(@event.food_trucks).to eq([])
  end
  
  it 'has a default date' do
    expect(@event.date).to be_a(String)
    expect(@event.date).to eq("24/02/2023")
  end

  it 'can be assigned a date other than the default' do
    @date = Time.new(1999, 12, 31)
    @event2 = Event.new("North Ruby Street Farmers Market", @date)

    expect(@event2.date).to eq("31/12/1999")
  end

  it 'can add food trucks' do
    @event.add_food_truck(@food_truck1)    
    @event.add_food_truck(@food_truck2)    
    @event.add_food_truck(@food_truck3)
    expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
  end

  it 'can display a list of food truck names' do
    @event.add_food_truck(@food_truck1)    
    @event.add_food_truck(@food_truck2)    
    @event.add_food_truck(@food_truck3)
    expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'can display a list of food trucks that have a certain item in stock' do
    @event.add_food_truck(@food_truck1)    
    @event.add_food_truck(@food_truck2)    
    @event.add_food_truck(@food_truck3)
    
    expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
    expect(@event.food_trucks_that_sell(@item2)).to eq([@food_truck1])
  end

  it 'can display an alphabetized list of available items' do
    @event.add_food_truck(@food_truck1)    
    @event.add_food_truck(@food_truck2)    
    @event.add_food_truck(@food_truck3)
    expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
  end

  it 'can display total available inventory' do
    @event.add_food_truck(@food_truck1)    
    @event.add_food_truck(@food_truck2)    
    @event.add_food_truck(@food_truck3)

    expect(@event.total_inventory).to eq({@item1 => {:quantity => 100, :food_trucks => [@food_truck1, @food_truck3]}, @item2 => {:quantity => 7, :food_trucks => [@food_truck1]}, @item4 => {:quantity => 50, :food_trucks => [@food_truck2]}, @item3 => {:quantity => 25, :food_trucks => [@food_truck2]}})
  end

  it 'can display overstocked items' do
    @event.add_food_truck(@food_truck1)    
    @event.add_food_truck(@food_truck2)    
    @event.add_food_truck(@food_truck3)

    expect(@event.overstocked_items).to eq([@item1])
  end
end