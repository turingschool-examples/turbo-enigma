class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    amount = @inventory[item] || 0
    return amount
  end

  def stock(item, amount)
    @inventory[item] = (@inventory[item] || 0) +amount
  end
end