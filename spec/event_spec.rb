require 'rspec'
require 'pry'
require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do
  before(:each) do
    @event = Event.new("South Pearl Street Farmers Market") 
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)

    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)

    @food_truck3.stock(@item1, 65)
  end

  describe 'initialize' do
    it 'exists' do
      expect(@event).to be_a Event
      expect(@event.name).to eq("South Pearl Street Farmers Market")
      expect(@event.food_trucks).to eq([])
    end
  end

  describe 'can track food trucks at event and information about them' do
    it 'can add food trucks' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)

      expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
    end

    it 'can tell you the name of the trucks at the event' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)

      expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'can tell you the trucks that sell specific items' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)

      expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
      expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
    end
  end

  describe 'can tell even more info about the event as a whole' do
    it 'can tell all items names, alphabetically' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      
      expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
    end

    it 'can tell total inventory across all present trucks' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)

      expect(@event.total_inventory).to eq(
          {
            "Apple Pie (Slice)" => {
              :food_trucks=>["Rocky Mountain Pies"], 
              :quantity=>7
            },
            "Banana Nice Cream" => {
              :food_trucks=>["Ba-Nom-a-Nom"], 
              :quantity=>50
            },
            "Peach Pie (Slice)" => {
              :food_trucks=>["Rocky Mountain Pies", "Palisade Peach Shack"], 
              :quantity=>100
            },
            "Peach-Raspberry Nice Cream" => {
              :food_trucks=>["Ba-Nom-a-Nom"], 
              :quantity=>25
            }
          })
      end

      it 'can tell overstocked items' do
        @event.add_food_truck(@food_truck1)
        @event.add_food_truck(@food_truck2)
        @event.add_food_truck(@food_truck3)

        expect(@event.overstocked_items).to eq(["Peach Pie (Slice)"])
      end
  end
end