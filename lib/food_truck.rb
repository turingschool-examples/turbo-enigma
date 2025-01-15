# frozen_string_literal: true

# Create a food truck to hold items
class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end
end
