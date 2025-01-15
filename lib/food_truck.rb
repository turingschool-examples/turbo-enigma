

class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def stock(item, stock)
    @inventory[item] ||= 0 
    @inventory[item] += stock
  end

    def potential_revenue
    @inventory.sum { |item, quantity| item.price * quantity }
  end
end