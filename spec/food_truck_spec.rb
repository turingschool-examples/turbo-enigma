require 'rspec'
require './lib/food_truck'

describe FoodTruck do
    before :each do
        @food_truck = FoodTruck.new("Rocky Mountain Pies")

        @item1 = double('First Item')
        @item2 = double('Second Item')
    end

    describe '#initialize' do
        it 'exists' do
            expect(@food_truck).to be_a(FoodTruck)
            expect(@food_truck.name).to eq("Rocky Mountain Pies")
            expect(@food_truck.inventory).to eq({})
        end
    end

    describe '#check_stock' do
        it 'can check the stock of an out of stock item' do
            expect(@food_truck.check_stock(@item1)).to eq(0)
        end

        it 'can check the stock of an in stock item' do
            @food_truck.stock(@item1, 30)

            expect(@food_truck.check_stock(@item1)).to eq(30)
        end
    end

    describe '#stock' do
        it 'can stock itself' do
            @food_truck.stock(@item1, 30)

            expect(@food_truck.inventory).to eq({
                @item1=>30
            })
        end

        it 'can add to existing stock' do
            @food_truck.stock(@item1, 30)
            @food_truck.stock(@item1, 25)

            expect(@food_truck.check_stock(@item1)).to eq 55
        end

        it 'can stock more than one type of item' do
            @food_truck.stock(@item1, 55)
            @food_truck.stock(@item2, 12)

            expect(@food_truck.check_stock(@item1)).to eq(55)
            expect(@food_truck.check_stock(@item2)).to eq(12)
        end
    end

    describe '#potential_revenue' do
        it 'can return its potential revenue' do
            allow(@item1).to receive(:price).and_return(3.75)
            allow(@item2).to receive(:price).and_return(2.50)

            @food_truck.stock(@item1, 35)
            @food_truck.stock(@item2, 7)

            expect(@food_truck.potential_revenue).to eq(148.75)
        end
    end

    describe '#sell' do
        it 'can sell items' do
            @food_truck.stock(@item1, 35)

            expect@food_truck.sell(@item1, 30)
            expect(@food_truck.check_stock(@item1)).to eq(5)
        end

        it 'can not oversell items' do
            @food_truck.stock(@item1, 35)

            expect(@food_truck.sell(@item1, 50)).to eq(false)
            expect(@food_truck.check_stock(@item1)).to eq(35)
        end
    end
end