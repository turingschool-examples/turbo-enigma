# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe FoodTruck do
  subject(:food_truck) { described_class.new('Rocky Mountain Pies') }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }
  end
end
