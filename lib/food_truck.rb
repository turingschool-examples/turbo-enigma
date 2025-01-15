class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if @inventory.has_key?(item)
      return @inventory[item]
    else
      return 0
    end
  end

  def stock(item, quantity)
    if @inventory.has_key?(item)
      @inventory[item] += quantity
    else
      @inventory[item] = quantity
    end
  end

  def potential_revenue
    sum = 0
    @inventory.each{|item, quantity| sum += (((item.price[1..-1]).to_f) * quantity)}
    return sum
  end
end