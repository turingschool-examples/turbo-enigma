require 'rspec'
require './lib/event'
require './lib/food_truck'
require './lib/item'
require 'pry'

describe Event do
    before :each do
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

        @event.add_food_truck(@food_truck1)
        @event.add_food_truck(@food_truck2)
        @event.add_food_truck(@food_truck3)
    end

    describe '#initialize' do
        it 'exists' do
            allow(Date).to receive(:today).and_return Date.new(2023, 1 , 8)

            event2 = Event.new("South Pearl Street Farmers Market")

            expect(event2).to be_a(Event)
            expect(event2.name).to eq("South Pearl Street Farmers Market")
            expect(event2.food_trucks).to eq([])
            expect(event2.date).to eq("08/01/2023")
        end
    end

    describe '#add_food_truck' do
        it 'can add food trucks' do
            expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
        end
    end

    describe '#food_truck_names' do
        it 'can list the names of all food trucks' do
            expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
        end
    end

    describe '#trucks_that_sell' do
        it 'can lists the trucks that sell a givin item' do
            expect(@event.trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
            expect(@event.trucks_that_sell(@item4)).to eq([@food_truck2])
        end
    end

    describe '#sorted_item_list' do
        it 'can return an alphabetical list off all items being sold' do
            expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)",
                                                    "Banana Nice Cream",
                                                    "Peach Pie (Slice)",
                                                    "Peach-Raspberry Nice Cream"
                                                ])
        end
    end

    describe '#total_inventory' do
        it 'can return the inventory of the entire event' do
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

    describe '#overstocked_items' do
        it 'can list any items that are overstocked' do
            expect(@event.overstocked_items).to eq([@item1])
        end
    end

    describe '#sell' do
        it 'can not sell items it does not have enough of' do
            expect(@event.sell(@item4, 80)).to eq(false)
            expect(@event.total_inventory[@item4][:quantity]).to eq(50)
        end

        it 'can sell items in the order that trucks were added' do
            expect(@event.sell(@item1, 40)).to eq(true)
            expect(@event.food_trucks[0].check_stock(@item1)).to eq(0)
            expect(@event.total_inventory[@item1][:quantity]).to eq(60)
        end
    end
end