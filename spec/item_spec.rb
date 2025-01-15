require './lib/item'
require 'pry'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@item1).to be_a Item
      expect(@item2).to be_a Item
    end

    it 'has a name' do
      expect(@item1.name).to eq("Peach Pie (Slice)")
      expect(@item2.name).to eq("Apple Pie (Slice)")
    end

    it 'has a price' do
      expect(@item1.price).to eq(3.75)
      expect(@item2.price).to eq(2.50)
    end
  end
end