

class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map{|truck| truck.name}
  end

  def food_trucks_that_sell(item)
    @food_trucks.select { |truck| truck.inventory.include?(item) }
  end

  def sorted_item_list
    food_list = @food_trucks.flat_map{ |truck| truck.inventory.keys.map{|nick| nick.name}}
    food_list.uniq.sort
  end

  def total_inventory
    binding.pry
  end

  def overstocked_items
    # binding.pry
  end
end