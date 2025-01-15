# frozen_string_literal: true

# Create a food truck to hold items
class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    return 0 unless @inventory[item.name]

    @inventory[item.name]
  end
end
