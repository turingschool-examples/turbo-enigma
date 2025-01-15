# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe FoodTruck do
  subject(:food_truck) { described_class.new('Rocky Mountain Pies') }

  let(:first_item) { instance_double(Item, name: 'Peach Pie (Slice)', price: 3.75) }
  let(:second_item) { instance_double(Item, name: 'Apple Pie (Slice)', price: 2.50) }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(food_truck.name).to eq('Rocky Mountain Pies')
    end

    it 'has empty inventory' do
      expect(food_truck.inventory).to eq({})
    end

    it 'has no stock' do
      expect(food_truck.check_stock(first_item)).to eq(0)
    end
  end

  describe '#stock' do
    before do
      food_truck.stock(first_item, 30)
    end

    it 'adds to inventory' do
      expect(food_truck.inventory).to eq({ first_item => 30 })
    end

    it 'adds to stock' do
      expect(food_truck.check_stock(first_item)).to eq(30)
    end

    it 'can add additional stock' do
      food_truck.stock(first_item, 25)

      expect(food_truck.check_stock(first_item)).to eq(55)
    end
  end
end
