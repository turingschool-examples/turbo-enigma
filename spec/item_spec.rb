require './lib/item'

describe Item do
  before :each do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@item1).to be_a(Item)
      expect(@item2).to be_a(Item)
    end
  end
end