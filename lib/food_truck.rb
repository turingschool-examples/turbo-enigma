# frozen_string_literal: true

# Create a food truck to hold items
class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    return 0 unless @inventory[item]

    @inventory[item]
  end

  def stock(item, amount)
    @inventory[item] = if inventory[item]
                         inventory[item] + amount
                       else
                         amount
                       end
  end
end
