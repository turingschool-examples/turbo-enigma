# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Event do
  subject(:event) { described_class.new('South Pearl Street Farmers Market') }

  let(:first_food_truck) { FoodTruck.new('Rocky Mountain Pies') }
  let(:second_food_truck) { FoodTruck.new('Ba-Nom-a-Nom') }
  let(:third_food_truck) { FoodTruck.new('Palisade Peach Shack') }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(event.name).to eq('South Pearl Street Farmers Market')
    end

    it 'has no food trucks' do
      expect(event.food_trucks).to eq([])
    end

    it 'has a date' do
      allow(Date).to receive(:today).and_return(Date.new(1912, 6, 23))

      expect(event.date).to eq('23/06/1912')
    end
  end

  describe '#add_food_truck' do
    before do
      event.add_food_truck(first_food_truck)
      event.add_food_truck(second_food_truck)
      event.add_food_truck(third_food_truck)
    end

    it 'can add food trucks' do
      expect(event.food_trucks).to eq([first_food_truck, second_food_truck, third_food_truck])
    end

    it 'can get food truck names' do
      expect(event.food_truck_names).to eq(['Rocky Mountain Pies', 'Ba-Nom-a-Nom', 'Palisade Peach Shack'])
    end
  end

  describe 'Methods with items' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:first_item) { instance_double(Item, name: 'Peach Pie (Slice)', price: 3.75) }
    let(:second_item) { instance_double(Item, name: 'Apple Pie (Slice)', price: 2.50) }
    let(:third_item) { instance_double(Item, name: 'Peach-Raspberry Nice Cream', price: 5.30) }
    let(:fourth_item) { instance_double(Item, name: 'Banana Nice Cream', price: 4.25) }

    before do
      event.add_food_truck(first_food_truck)
      event.add_food_truck(second_food_truck)
      event.add_food_truck(third_food_truck)
      first_food_truck.stock(first_item, 35)
      first_food_truck.stock(second_item, 7)
      second_food_truck.stock(third_item, 25)
      second_food_truck.stock(fourth_item, 50)
      third_food_truck.stock(first_item, 65)
    end

    describe '#food_trucks_that_sell' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      it 'can find trucks that sell item' do
        expect(event.food_trucks_that_sell(first_item)).to eq([first_food_truck, third_food_truck])
      end
    end

    describe '#sorted_item_list' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      it 'can get sorted item list' do # rubocop:disable RSpec/ExampleLength
        expect(event.sorted_item_list).to eq([
                                               'Apple Pie (Slice)',
                                               'Banana Nice Cream',
                                               'Peach Pie (Slice)',
                                               'Peach-Raspberry Nice Cream'
                                             ])
      end
    end

    describe '#total_inventory' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      it 'can get total inventory' do # rubocop:disable RSpec/ExampleLength
        expect(event.total_inventory).to eq({
                                              first_item => {
                                                quantity: 100,
                                                food_trucks: [first_food_truck, third_food_truck]
                                              },
                                              second_item => {
                                                quantity: 7,
                                                food_trucks: [first_food_truck]
                                              },
                                              third_item => {
                                                quantity: 25,
                                                food_trucks: [second_food_truck]
                                              },
                                              fourth_item => {
                                                quantity: 50,
                                                food_trucks: [second_food_truck]
                                              }
                                            })
      end
    end

    describe '#overstocked_items' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      it 'can get overstocked items' do
        expect(event.overstocked_items).to eq([first_item])
      end
    end

    describe '#sell' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      it 'cannot sell more items than it has' do
        expect(event.sell(second_item, 8)).to be false
      end

      it 'can sell items' do
        expect(event.sell(first_item, 40)).to be true
      end

      it 'can sell items from multiple trucks' do # rubocop:disable RSpec/ExampleLength
        event.sell(first_item, 40)

        expect(event.total_inventory).to eq({
                                              first_item => {
                                                quantity: 60,
                                                food_trucks: [third_food_truck]
                                              },
                                              second_item => {
                                                quantity: 7,
                                                food_trucks: [first_food_truck]
                                              },
                                              third_item => {
                                                quantity: 25,
                                                food_trucks: [second_food_truck]
                                              },
                                              fourth_item => {
                                                quantity: 50,
                                                food_trucks: [second_food_truck]
                                              }
                                            })
      end
    end
  end
end
