# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Item do
  subject(:item) { described_class.new({ name: 'Peach Pie (Slice)', price: '$3.75' }) }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(item.name).to eq('Peach Pie (Slice)')
    end

    it 'has a price' do
      expect(item.price).to eq(3.75)
    end
  end
end
