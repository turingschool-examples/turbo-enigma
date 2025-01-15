#create an Event with attributes (name, food_trucks)

class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map { |truck| truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.select { |truck| truck.inventory.include?(item) }
  end

  def sorted_item_list
    @food_trucks.flat_map { |truck| truck.inventory.keys.map { |item| item.name } }.uniq.sort
  end

  def total_inventory
    inventory = Hash.new { |hash, key| hash[key] = { quantity: 0, food_trucks: [] } }
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        inventory[item][:quantity] += quantity
        inventory[item][:food_trucks] << truck
      end
    end
    inventory
  end

  def overstocked_items
    total_inventory.select { |item, data| data[:quantity] > 50 && data[:food_trucks].size > 1 }.keys
  end
end
