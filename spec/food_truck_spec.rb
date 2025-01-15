# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe FoodTruck do
  subject(:food_truck) { described_class.new('Rocky Mountain Pies') }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(food_truck.name).to eq('Rocky Mountain Pies')
    end
  end
end
