require './lib/item.rb'
require './lib/food_truck.rb'
require './lib/event.rb'

RSpec.describe do
  before(:each) do
    @event = Event.new("South Pearl Street Farmers Market")
  end

  it 'exists' do
    expect(@event).to be_a(Event)
  end

  it 'initializes correctly' do
    expect(@event.name).to eq("South Pearl Street Farmers Market")
    expect(@event.food_trucks).to eq([])
  end

end