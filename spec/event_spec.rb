require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do 
    before (:each) do 
        @event = Event.new("South Pearl Street Farmers Market")
        @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
        @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
        @food_truck3 = FoodTruck.new("Palisade Peach Shack")
        @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
        @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
        @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
        @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    end

    it 'exists' do
        expect(@event).to be_an Event
        expect(@event.name).to eq("South Pearl Street Farmers Market")
        expect(@event.food_trucks).to eq([])
    end

    describe '#stock' do
        it "stocks food truck 1 with items" do 
            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)

            expect(@food_truck1.check_stock(@item1)).to eq(35)
            expect(@food_truck1.check_stock(@item2)).to eq(7)
            expect(@food_truck1.inventory).to eq({@item1 => 35, @item2 => 7})
        end

        it "stocks food truck 2 with items" do
            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)

            expect(@food_truck2.check_stock(@item4)).to eq(50)
            expect(@food_truck2.check_stock(@item3)).to eq(25)
            expect(@food_truck2.inventory).to eq({@item4 => 50, @item3 => 25})
        end

        it "stocks food truck 3 with items" do 
            @food_truck3.stock(@item1, 65)

            expect(@food_truck3.check_stock(@item1)).to eq(65)
            expect(@food_truck3.inventory).to eq({@item1 => 65})
        end
    end

    describe '#add_food_truck' do 
        it "adds food trucks to the food truck array" do 
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
        end

        it "returns the food trucks names" do
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
        end
    end

    describe '#food_trucks_that_sell(items)' do
        it "returns food trucks that sell a certain item" do 
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)
            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)
            @food_truck3.stock(@item1, 65)

            expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
            expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
        end
    end

    describe '#potential_revenue' do
        it "returns the potential revenue if they sell out of each item" do 
            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)
            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)
            @food_truck3.stock(@item1, 65)

            expect(@food_truck1.potential_revenue).to eq(148.75)
            expect(@food_truck2.potential_revenue).to eq(345.00)
            expect(@food_truck3.potential_revenue).to eq(243.75)
        end
    end

    describe '#sorted_item_list' do
        it "returns an array of all food truck items" do 
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)
            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)
            @food_truck3.stock(@item1, 65)
       
            expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
        end
    end

    describe '#total_inventory' do 
        it 'returns a has of total inventory of all items sold at the event' do 
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)
            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)
            @food_truck3.stock(@item1, 65)

            expect(@event.total_inventory).to eq({
                @item1 => {
                    quantity: 100, 
                    food_trucks: [@food_truck1, @food_truck3]
                }, 
                @item2 => {
                    quantity: 7, 
                    food_trucks: [@food_truck1]
                },
                @item3 => {
                    quantity: 25, 
                    food_trucks: [@food_truck2]
                },
                @item4 => {
                    quantity: 50, 
                    food_trucks: [@food_truck2]
                }
            })
        end
    end
end     
