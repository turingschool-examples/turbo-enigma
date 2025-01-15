require './lib/food_truck'
require './lib/item'

describe FoodTruck do
  before :each do
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@food_truck).to be_a(FoodTruck)
    end
  end

  describe 'inventory' do
    it 'can return inventory' do
      expect(@food_truck.inventory).to eq({})
    end
  end

  describe '#check_stock' do
    it 'can return stock of specified item' do
      expect(@food_truck.check_stock(@item1)).to eq(0)
    end
  end

  describe '#stock' do
    it 'can stock items' do
      @food_truck.stock(@item1, 30)
      expect(@food_truck.check_stock(@item1)).to eq(30)
      @food_truck.stock(@item1, 25)
      expect(@food_truck.check_stock(@item1)).to eq(55)
      expect(@food_truck.check_stock(@item2)).to eq(0)
      @food_truck.stock(@item2, 12)
      expect(@food_truck.check_stock(@item2)).to eq(12)
    end
  end

  describe '#potential_revenue' do
    it 'returns total amount of potential revenue from stock' do
      @food_truck.stock(@item1, 35)
      expect(@food_truck.potential_revenue).to eq(131.25)
      @food_truck.stock(@item2, 7)
      expect(@food_truck.potential_revenue).to eq(148.75)
    end
  end
end