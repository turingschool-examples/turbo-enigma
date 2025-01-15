require './lib/item'

RSpec.describe Item do
  it 'exists and has attributes' do
    item = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})

    expect(item).to be_an_instance_of(Item)
    expect(item.name).to eq('Peach Pie (Slice)')
    expect(item.price).to eq(3.75)
  end
end
