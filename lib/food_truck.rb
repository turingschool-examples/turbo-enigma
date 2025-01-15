class FoodTruck
  attr_reader :name, :inventory, :stock

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if @inventory == {}
      return 0
    else
      return @inventory[:item]
    end
  end

  def stock(item, amount)
    @inventory[item] += amount
  end

  def potential_revenue
    
  end
end