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

  def sorted_item_list
    item_arrays = []
    items = []

    @food_trucks.each {|truck| item_arrays << truck.inventory.keys}

    item_arrays.each do |item_array| 
      item_array.each do |item|
        items << item.name
      end
    end
    
    return items.uniq.sort

  end

  def total_inventory
    
  end

  def overstocked_items
    
  end
end