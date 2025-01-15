require './lib/item'
require 'pry'

RSpec.describe Item do
  it 'exists and has attributes' do
    @item = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item2 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    
    expect(@item).to be_a(Item)
    expect(@item2).to be_a(Item)
    expect(@item.name).to eq('Apple Pie (Slice)')
    expect(@item2.name).to eq('Peach Pie (Slice)')
    expect(@item.price).to eq(2.50)
    expect(@item2.price).to eq(3.75)
  end

end