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
    inventory_hash = {}

    @food_trucks.each do |truck| 
      truck.inventory.each do |item, quantity|
        if inventory_hash.has_key?(item)
          inventory_hash[item][:quantity] += quantity
        else
          inventory_hash[item] = {quantity: quantity, food_trucks: food_trucks_that_sell(item)}
        end
      end
    end
    
    return inventory_hash
  end

  def overstocked_items
    
  end
end