# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Event do # rubocop:disable RSpec/MultipleMemoizedHelpers
  subject(:event) { described_class.new('South Pearl Street Farmers Market') }

  let(:first_food_truck) { instance_double(FoodTruck, name: 'Rocky Mountain Pies') }
  let(:second_food_truck) { instance_double(FoodTruck, name: 'Ba-Nom-a-Nom') }
  let(:third_food_truck) { instance_double(FoodTruck, name: 'Palisade Peach Shack') }
  let(:first_item) { instance_double(Item, name: 'Peach Pie (Slice)', price: 3.75) }
  let(:second_item) { instance_double(Item, name: 'Apple Pie (Slice)', price: 2.50) }
  let(:third_item) { instance_double(Item, name: 'Peach-Raspberry Nice Cream', price: 5.30) }
  let(:fourth_item) { instance_double(Item, name: 'Banana Nice Cream', price: 4.25) }

  describe '#initialize' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(event.name).to eq('South Pearl Street Farmers Market')
    end

    it 'has no food trucks' do
      expect(event.food_trucks).to eq([])
    end
  end

  describe '#add_food_truck' do # rubocop:disable RSpec/MultipleMemoizedHelpers
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
end
