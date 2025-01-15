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
    @inventory[item] = check_stock(item) + quantity
  end

  def potential_revenue
    total_revenue = 0
    @inventory.each do |item, quantity|
      total_revenue += item.price * quantity  
    end
    total_revenue
  end
end
