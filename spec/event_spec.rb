require './lib/item.rb'
require './lib/food_truck.rb'
require './lib/event.rb'
require 'pry'

RSpec.describe do
  before(:each) do
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")  
    @food_truck3 = FoodTruck.new("Palisade Peach Shack") 
    @food_truck4 = FoodTruck.new("Ernie's")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @item5 = Item.new({name: "Peach Cobbler", price: "$3.50"})
  end

  it 'exists' do
    expect(@event).to be_a(Event)
  end

  it 'initializes correctly' do
    expect(@event.name).to eq("South Pearl Street Farmers Market")
    expect(@event.food_trucks).to eq([])
  end

  it 'can track all food trucks for an event, and list their names' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
    expect(@event.food_truck_names()).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'can list all trucks that sell a specific item' do
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @event.add_food_truck(@food_truck1)
    @food_truck2.stock(@item3, 25)
    @food_truck2.stock(@item4, 50)
    @event.add_food_truck(@food_truck2)
    @food_truck3.stock(@item1, 65)
    @event.add_food_truck(@food_truck3)

    expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
    expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
  end

  it 'can determine potential revenue on food trucks for event' do
    #Note: this tests is somewhat already done in food_truck_spec.rb, but repeated here to follow interaction pattern
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @event.add_food_truck(@food_truck1)
    @food_truck2.stock(@item3, 25)
    @food_truck2.stock(@item4, 50)
    @event.add_food_truck(@food_truck2)
    @food_truck3.stock(@item1, 65)
    @event.add_food_truck(@food_truck3)

    expect(@food_truck1.potential_revenue()).to eq(148.75)
    expect(@food_truck2.potential_revenue()).to eq(345.00)
    expect(@food_truck3.potential_revenue()).to eq(243.75)
  end

  it 'can provide a sorted list of item names that are sold at the event' do
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @event.add_food_truck(@food_truck1)
    @food_truck2.stock(@item3, 25)
    @food_truck2.stock(@item4, 50)
    @event.add_food_truck(@food_truck2)
    @food_truck3.stock(@item1, 65)
    @event.add_food_truck(@food_truck3)

    expect(@event.sorted_item_list()).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])

    @food_truck4.stock(@item2, 11)
    @food_truck4.stock(@item5, 17)
    @event.add_food_truck(@food_truck4)

    expect(@event.sorted_item_list()).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Cobbler", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
  end

end