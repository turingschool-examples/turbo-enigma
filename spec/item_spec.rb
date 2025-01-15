require './lib/item'
require 'pry'

RSpec.describe Item do
  it 'exists' do
    @item = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    
    expect(@item).to be_a(Item)
  end

end