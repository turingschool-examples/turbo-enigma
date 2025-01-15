# frozen_string_literal: true

# Create a food truck to hold items
class FoodTruck
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
