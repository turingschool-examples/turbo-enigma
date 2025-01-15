require "./spec/spec_helper.rb"


RSpec.describe FoodTruck do
  before(:each) do
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  describe 'initialize' do
    it 'exists' do
      expect(@food_truck).to be_an_instance_of(FoodTruck)
    end
    it 'has name' do
      expect(@food_truck.name).to eq("Rocky Mountain Pies")
    end
    it 'has inventory hash' do
      expect(@food_truck.inventory).to eq({})
    end
  end

  describe "methods" do
    it 'can stock item' do
      @food_truck.stock(@item1, 30)
      @food_truck.stock(@item1, 30)
      @food_truck.stock(@item2, 12)
      expect(@food_truck.inventory).to eq({@item1 => 60, @item2 => 12})
    end

    it 'can calculate potential revenue' do
      @food_truck.stock(@item1, 10)

      expect(@food_truck.potential_revenue).to eq(37.50)
    end
  end
end