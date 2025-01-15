require 'rspec'
require './lib/food_truck'

describe FoodTruck do
    before :each do
        @food_truck = FoodTruck.new("Rocky Mountain Pies")

        @item1 = double('First Item')
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
    end

    describe '#stock' do
        it 'can stock itself' do
            @food_truck.stock(@item1, 30)

            expect(@food_truck.inventory).to eq({
                @item1=>30
            })
        end
    end
end