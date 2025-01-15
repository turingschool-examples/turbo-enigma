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

  def potential_revenue
    total_revenue = 0.0

    @inventory.each do |item, amount|
      total_revenue += item.price.delete('$').to_f * amount
    end

    total_revenue
  end
end