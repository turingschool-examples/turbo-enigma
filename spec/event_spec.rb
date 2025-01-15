# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Event do
  subject(:event) { described_class.new('South Pearl Street Farmers Market') }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }
  end
end
