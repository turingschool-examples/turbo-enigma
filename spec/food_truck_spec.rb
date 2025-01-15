require 'rspec'
require './lib/food_truck'
require './lib/item'

describe FoodTruck do
    before :each do
        @food_truck = FoodTruck.new("Rocky Mountain Pies")
    end

    describe '#initialize' do
        it 'exists' do
            expect(@food_truck).to be_a(FoodTruck)
            expect(@food_truck.name).to eq("Rocky Mountain Pies")
        end
    end
end