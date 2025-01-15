# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end
require 'pry'
require 'rspec'

require_relative '../lib/event'
require_relative '../lib/food_truck'
require_relative '../lib/item'

RSpec.configure(&:disable_monkey_patching!)
