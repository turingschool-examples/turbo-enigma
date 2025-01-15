require './lib/item'
require './lib/food_truck'

RSpec.describe FoodTruck do
  before(:each) do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  describe '#initialize' do
    it 'exists' do
      expect(@food_truck).to be_a FoodTruck
    end

    it 'has a name' do
      expect(@food_truck.name).to eq("Rocky Mountain Pies")
    end
  end

  describe '#inventory' do
    it 'defaults an empty hash' do
      expect(@food_truck.inventory).to eq({})
    end

    it 'adds single item to hash' do
      @food_truck.stock(@item1, 30)

      expect(@food_truck.inventory).to eq({@item1 => 30})
    end

    it 'updates item amount' do
      @food_truck.stock(@item1, 30)
      @food_truck.stock(@item1, 25)

      expect(@food_truck.inventory).to eq({@item1 => 55)
    end

    it 'updates item amount & adds another item to hash' do
      @food_truck.stock(@item1, 30)
      @food_truck.stock(@item1, 25)

      @food_truck.stock(@item2, 12)
      
      expect(@food_truck.inventory).to eq({@item1 => 55, @item2 => 12})    end
  end
  describe '#check_stock' do
    it 'defaults 0' do
      expect(@food_truck.check_stock(@item1)).to eq(0)
    end

    it 'adds stock of item' do
      @food_truck.stock(@item1, 30)

      expect(@food_truck.check_stock(@item1)).to eq(30)
    end

    it 'keeps running count of item stock' do
      @food_truck.stock(@item1, 30)
      @food_truck.stock(@item1, 25)

      expect(@food_truck.check_stock(@item1)).to eq(55)
    end
  end
end



