require './lib/item'
require './lib/food_truck'
require './lib/event'
require 'pry'

RSpec.describe FoodTruck do
  before(:each) do
    @event = Event.new("South Pearl Street Farmers Market")
    @foodtruck1 = FoodTruck.new("Rocky Mountain Pies")
    @foodtruck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @foodtruck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end
  it 'exists and has attributes' do

    @event = Event.new("South Pearl Street Farmers Market")

    expect(@event).to be_an_instance_of(Event)
    expect(@event.name).to eq("South Pearl Street Farmers Market")
    expect(@event.food_trucks).to eq([])
  end

  it 'can add food trucks to an event' do

    event = Event.new("South Pearl Street Farmers Market")
    

    event.add_food_truck(@foodtruck1)
    event.add_food_truck(@foodtruck2)
    event.add_food_truck(@foodtruck3)

    expect(event.food_trucks).to eq([@foodtruck1, @foodtruck2, @foodtruck3])
    expect(event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'can find food trucks that sell a given item' do

    @foodtruck1.stock(@item1, 35)
    @foodtruck1.stock(@item2, 7)
    @foodtruck2.stock(@item4, 50)
    @foodtruck2.stock(@item3, 25)
    @foodtruck3.stock(@item1, 65)

    @event.add_food_truck(@foodtruck1)
    @event.add_food_truck(@foodtruck2)
    @event.add_food_truck(@foodtruck3)

    expect(@event.food_trucks_that_sell(@item1)).to eq([@foodtruck1, @foodtruck3])
    expect(@event.food_trucks_that_sell(@item4)).to eq([@foodtruck2])
  end


  it 'can calculate potential revenue' do

    @foodtruck1.stock(@item1, 35)
    @foodtruck1.stock(@item2, 7)
    @foodtruck2.stock(@item4, 50)
    @foodtruck2.stock(@item3, 25)
    @foodtruck3.stock(@item1, 65)

    expect(@foodtruck1.potential_revenue).to eq(148.75)
    expect(@foodtruck2.potential_revenue).to eq(345.00)
    expect(@foodtruck3.potential_revenue).to eq(243.75)
  end
  it 'returns a sorted list of item names' do

    @foodtruck1.stock(@item1, 35)
    @foodtruck1.stock(@item2, 7)
    @foodtruck2.stock(@item3, 50)
    @foodtruck2.stock(@item4, 25)
    @foodtruck3.stock(@item1, 65)

    @event.add_food_truck(@foodtruck1)
    @event.add_food_truck(@foodtruck2)
    @event.add_food_truck(@foodtruck3)

    expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
  end

  it 'can return total inventory for the event' do

    @foodtruck1.stock(@item1, 35)
    @foodtruck1.stock(@item2, 7)
    @foodtruck2.stock(@item3, 50)
    @foodtruck2.stock(@item4, 25)
    @foodtruck3.stock(@item1, 65)

    @event.add_food_truck(@foodtruck1)
    @event.add_food_truck(@foodtruck2)
    @event.add_food_truck(@foodtruck3)

    expect(@event.total_inventory).to eq({
      @item1 => { quantity: 100, food_trucks: [@foodtruck1, @foodtruck3] },
      @item2 => { quantity: 7, food_trucks: [@foodtruck1] },
      @item3 => { quantity: 50, food_trucks: [@foodtruck2] },
      @item4 => { quantity: 25, food_trucks: [@foodtruck2] }
    })
  end

  it 'can return overstocked items' do
    @foodtruck1.stock(@item1, 35)
    @foodtruck1.stock(@item2, 7)
    @foodtruck2.stock(@item3, 50)
    @foodtruck2.stock(@item4, 25)
    @foodtruck3.stock(@item1, 16)

    @event.add_food_truck(@foodtruck1)
    @event.add_food_truck(@foodtruck2)
    @event.add_food_truck(@foodtruck3)

    expect(@event.overstocked_items).to eq([@item1])
  end

  it 'can sell items from stock' do
    @foodtruck1.stock(@item1, 35)
    @foodtruck3.stock(@item1, 65)
    
    @event.add_food_truck(@foodtruck1)
    @event.add_food_truck(@foodtruck3)

    expect(@event.sell(@item1, 20)).to be true
    expect(@foodtruck1.inventory[@item1]).to eq(15)
    expect(@foodtruck3.inventory[@item1]).to eq(65)
  end

  it 'returns false when there is not enough stock to sell' do
    @foodtruck1.stock(@item1, 35)
    @foodtruck3.stock(@item1, 20)
    
    @event.add_food_truck(@foodtruck1)
    @event.add_food_truck(@foodtruck3)

    expect(@event.sell(@item1, 100)).to be false
  end

  it 'sells from multiple food trucks' do
    @foodtruck1.stock(@item1, 90)
    @foodtruck3.stock(@item1, 60)

    @event.add_food_truck(@foodtruck1)
    @event.add_food_truck(@foodtruck3)

    expect(@event.sell(@item1, 140)).to be true
    expect(@foodtruck1.inventory[@item1]).to eq(0)
    expect(@foodtruck3.inventory[@item1]).to eq(10)
  end
end