require './lib/item.rb'
require 'pry'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  it 'exists' do
    expect(@item1).to be_a(Item)
    expect(@item2).to be_a(Item)
  end

  it 'initializes correctly: has a name and price' do
    expect(@item2.name).to eq("Apple Pie (Slice)")
    expect(@item2.price).to eq(2.50)
  end

end
