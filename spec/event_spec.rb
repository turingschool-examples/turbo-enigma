require 'rspec'
require './lib/event'

describe Event do
    before :each do
        @event = Event.new("South Pearl Street Farmers Market")
    end

    describe '#initialize' do
        it 'exists' do
            expect(@event).to be_a(Event)
            expect(@event.name).to eq("South Pearl Street Farmers Market")
            expect(@event.food_trucks).to eq([])
        end
    end
end