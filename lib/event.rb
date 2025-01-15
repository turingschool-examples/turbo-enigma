class Event
  attr_reader :name, :food_trucks, :date

  def initialize(name, date = Date.new(2023, 02, 24))
    @name = name
    @food_trucks = []
    @date = date
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
    overstocked = []
    total_inventory = self.total_inventory

    total_inventory.each do |item, details|
      if (details[:quantity] > 50) || (details[:food_trucks].size > 1)
        overstocked << item
      end
    end

    return overstocked
  end
end