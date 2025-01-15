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
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |truck|
      if truck.inventory.has_key?(item)
        truck
      end
    end
  end

  def sorted_item_list
    sorted_items = []
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        sorted_items << item.name
      end
    end
  sorted_items.uniq.sort
  end

  def overstocked_items
    overstock = Hash.new { 
      |hash, key| hash[key] = { quantity: 0, trucks: 0 } 
    }
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        overstock[item][:quantity] += quantity
        overstock[item][:trucks] += 1
      end
    end
    overstock.select do |item, info|
      info[:trucks] > 1 && info[:quantity] > 50
    end.keys
  end
end