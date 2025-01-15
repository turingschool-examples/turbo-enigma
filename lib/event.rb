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
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    item_carriers = []

    @food_trucks.each do |food_truck|
      if food_truck.check_stock(item) != 0
        item_carriers << food_truck
      end
    end

    item_carriers
  end

  def sorted_item_list
    item_names = []

    @food_trucks.each do |food_truck|

      food_truck.inventory.each do |item, price|
        if !item_names.include?(item.name)
          item_names << item.name
        end
      end
    end

    item_names.sort
  end

  def total_inventory
    total_inventory = {}

    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, amount|
      
        if total_inventory[item.name] != nil
        total_inventory[item.name][:quantity] += amount
        total_inventory[item.name][:food_trucks] << food_truck.name unless total_inventory[item.name][:food_trucks].include?(food_truck.name)
        else
          total_inventory[item.name] = { quantity: amount, food_trucks: [food_truck.name] }
        end
      end
    end

    total_inventory
  end
end