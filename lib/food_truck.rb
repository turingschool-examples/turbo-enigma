#create FoodTruck with attributes (name, inventory)

class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0) #Hash.new creates a new hash with a default value of 0
  end

  def check_stock(item) #returns the quantity of the item
    @inventory[item] #@inventory is a hash with the item as the key & quantity as the value
  end

  def stock(item, quantity) #will add the item to the inventory hash
    @inventory[item] += quantity #syntax for adding to a hash is hash[key] += value
  end

  def potential_revenue #is calculated by multiplying the price of each item by the quantity of that item
    @inventory.sum { |item, quantity| item.price * quantity }
  end
end
