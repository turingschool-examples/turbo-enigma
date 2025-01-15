# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Item do
  subject(:first_item) { described_class.new({ name: 'Peach Pie (Slice)', price: '$3.75' }) }

  let(:second_item) { described_class.new({ name: 'Apple Pie (Slice)', price: '$2.50' }) }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }
  end
end
