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
    @food_trucks.each do |truck|
      names << truck.name
    end
    names
  end

  def food_trucks_that_sell(item)
    @food_trucks.select { |truck| truck.inventory.key?(item) }
  end

  def sorted_item_list
    @food_trucks.each_with_object([]) do |truck, item_names|
      truck.inventory.each_key { |item| item_names << item.name }
    end.uniq.sort
  end

  def total_inventory
    @food_trucks.each_with_object({}) do |truck, inventory_hash|
      truck.inventory.each do |item, quantity|
       
        if inventory_hash[item].nil?
          inventory_hash[item] = { quantity: 0, food_trucks: [] }
        end
  
        
        inventory_hash[item][:quantity] += quantity
  
        
        unless inventory_hash[item][:food_trucks].include?(truck)
          inventory_hash[item][:food_trucks] << truck
        end
      end
    end
  end

  def overstocked_items
    total_inventory.select do |item, data|
      data[:food_trucks].size > 1 && data[:quantity] > 50
    end.keys
  end

  def sell(item, quantity)
   
    total_available = @food_trucks.sum { |truck| truck.inventory[item] || 0 }
  
    return false if total_available < quantity
  
    remaining_quantity = quantity
    @food_trucks.each do |truck|
      
      if truck.inventory[item] > 0 && remaining_quantity > 0
        sold = [truck.inventory[item], remaining_quantity].min
        truck.inventory[item] -= sold
        remaining_quantity -= sold
      end
    end
  
    true
  end
end