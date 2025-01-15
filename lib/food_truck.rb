
class FoodTruck
attr_reader :name, :inventory
  
  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    @inventory[item] || 0
  end

  def stock(item, quantity)
    if @inventory[item]
      @inventory[item] += quantity
    else
      @inventory[item] = quantity
    end
  end

  def potential_revenue
    @inventory.sum do |item, quantity|
      item.price.delete('$').to_f * quantity
    end
  end
end