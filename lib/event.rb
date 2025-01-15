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

  def total_inventory()
    #Returns hash of all items; for each item, has a hash of the total quantity and array of trucks stocking that item
    total_inventory = {}

    # @food_trucks.each do |truck|
    #   #For each truck, check inventory
      
    #   binding.pry

    # end

    #Alternate approach: look at all item names and trace to trucks, etc.
    sorted_item_list().each do |item_name|

      #Create hash:
      item_info_hash = {}     #Keys are :quantity and :food_trucks
      trucks_with_item = []
      # current_item = nil
      total_item_inventory = 0
      @food_trucks.each do |truck|

        # binding.pry

        #First, backtrace to find the item based on its name (argh):
        current_item = truck.inventory.keys.to_a.find do |inventory_item|
          inventory_item.name == item_name
        end
        total_item_inventory += truck.check_stock(current_item)
        trucks_with_item << truck if truck.check_stock(current_item) > 0
      end

      # total_item_inventory = trucks_with_item.sum do |truck|
      #   truck.check_stock(current_item)
      # end

      
      # item_info_hash[item_name] = {quantity: total_item_inventory, food_trucks: trucks_with_item}
      total_inventory[item_name] = {quantity: total_item_inventory, food_trucks: trucks_with_item}
      # total_inventory[item_name]
      
      # binding.pry
      
    end

    binding.pry

    total_inventory
    # if truck.check_stock() > 0
    #   #Truck has the item - add it to the array
    #   trucks_with_item << truck
    # end
  end

end