require "./spec/spec_helper.rb"


RSpec.describe Event do
  before(:each) do
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")

    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @event = Event.new("South Pearl Street Farmers Market")

    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
  end

  describe 'initialize' do
    it 'exists' do
      expect(@event).to be_an_instance_of(Event)
    end
    it 'has a name' do
      expect(@event.name).to eq("South Pearl Street Farmers Market")
    end
    it 'has food truck array' do
      expect(@event.food_trucks).to eq([])
    end
  end

  describe 'methods' do
    it 'can add food truck' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
    end
    
    it 'can get name' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      
      expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'can locate trucks that sell an item' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)

      expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
    end

    it 'can sort food truck items by name' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.sorted_item_list).to eq(['Apple Pie (Slice)', "Banana Nice Cream", 'Peach Pie (Slice)', "Peach-Raspberry Nice Cream"])
    end

    it 'can grab total inventory' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.total_inventory).to eq({})
    end

    xit 'can find overstocked items' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.overstocked_items).to eq([@item1])
    end
  end
end

    # @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    # @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    # @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    # @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    # @food_truck1.stock(@item1, 35)
    # @food_truck1.stock(@item2, 7)
    # @food_truck2.stock(@item4, 50)
    # @food_truck2.stock(@item3, 25)
    # @food_truck3.stock(@item1, 65)