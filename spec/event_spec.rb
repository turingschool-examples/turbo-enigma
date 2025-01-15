# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Event do
  subject(:event) { described_class.new('South Pearl Street Farmers Market') }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(event.name).to eq('South Pearl Street Farmers Market')
    end

    it 'has no food trucks' do
      expect(event.food_trucks).to eq([])
    end
  end
end
