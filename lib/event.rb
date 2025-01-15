class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name

    @food_trucks = []

  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names()
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(specified_item)
    @food_trucks.find_all do |truck|
      truck.inventory[specified_item] != nil
    end
  end

  def sorted_item_list()
    #Returns sorted list of the names of all food items that are at the event
    unique_items_name_list = @food_trucks.map do |truck|

      # binding.pry

      truck.inventory.keys.map do |key|
        key.name
      end
    end.flatten.uniq
    
    unique_items_name_list.sort     #Default is alphabetical
  end

end