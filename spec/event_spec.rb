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
    end

    describe '#initialize' do 
        it 'exists' do 
            expect(@event).to be_an(Event)
        end
    end

    describe '#attributes' do 
        it 'has a name' do 
            expect(@event.name).to eq("South Pearl Street Farmers Market")  
        end

        it 'can host multiple food_trucks at the event and defaults as empty array' do 
            expect(@event.food_trucks).to eq([])
        end
    end

    describe '#add_food_truck' do 
        it 'adds a new food_truck to the event in the food_trucks array' do 
            @event.add_food_truck(@food_truck1)   
            @event.add_food_truck(@food_truck2)   
            @event.add_food_truck(@food_truck3)   

            expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
        end
    end

    describe '#food_truck_names' do 
        it 'can return a list of the names of the food_trucks at the event' do 
            @event.add_food_truck(@food_truck1)   
            @event.add_food_truck(@food_truck2)   
            @event.add_food_truck(@food_truck3) 

            expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
        end
    end

    describe '#food_trucks_that_sell' do 
        it 'returns a list of food_trucks that sell a particular item' do 
            @food_truck1.stock(@item1, 35)    
            @food_truck1.stock(@item2, 7) 
            
            @food_truck2.stock(@item4, 50)    
            @food_truck2.stock(@item3, 25)

            @food_truck3.stock(@item1, 65)  

            @event.add_food_truck(@food_truck1)    
            @event.add_food_truck(@food_truck2)    
            @event.add_food_truck(@food_truck3)

            expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
            expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
        end
    end

    describe '#sorted_items' do 
        it 'returns a list of all items sold at the event in alphabetical order without duplicates' do 
            @food_truck1.stock(@item1, 35)    
            @food_truck1.stock(@item2, 7) 
            
            @food_truck2.stock(@item4, 50)    
            @food_truck2.stock(@item3, 25)

            @food_truck3.stock(@item1, 65)  

            @event.add_food_truck(@food_truck1)    
            @event.add_food_truck(@food_truck2)    
            @event.add_food_truck(@food_truck3)

            expect(@event.sorted_item_list).to eq(['Apple Pie (Slice)', "Banana Nice Cream", 'Peach Pie (Slice)', "Peach-Raspberry Nice Cream"])
        end
    end

    describe '#overstocked_items' do 
        it 'returns a list of overstocked items for an event' do
            @food_truck1.stock(@item1, 35)    
            @food_truck1.stock(@item2, 7) 
            
            @food_truck2.stock(@item4, 55)    
            @food_truck2.stock(@item3, 25)

            @food_truck3.stock(@item1, 65)  
            @food_truck3.stock(@item2, 8)  

            @event.add_food_truck(@food_truck1)    
            @event.add_food_truck(@food_truck2)    
            @event.add_food_truck(@food_truck3)

            expect(@event.overstocked_items).to eq([@item1, @item2, @item4])
        end
    end
end