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
    names = []
    @food_trucks.each {|truck| names << truck.name}
    return names
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all {|truck| (truck.check_stock(item) > 0)}
  end
end