require 'date'

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
    unique_items_name_list = @food_trucks.map do |truck|
      truck.inventory.keys.map do |key|
        key.name
      end
    end.flatten.uniq
    
    unique_items_name_list.sort     #Default is alphabetical for strings (yay)
  end

  def total_inventory()
    #Returns hash of all items; for each item, has a hash of the total quantity and array of trucks stocking that item
    total_inventory = {}

    sorted_item_list().each do |item_name|
      trucks_with_item = []
      total_item_inventory = 0

      @food_trucks.each do |truck|
        #Backtrace to find the item based on its name (argh):
        current_item = truck.inventory.keys.find do |inventory_item|
          inventory_item.name == item_name
        end

        total_item_inventory += truck.check_stock(current_item)
        trucks_with_item << truck if truck.check_stock(current_item) > 0
      end
      
      total_inventory[item_name] = {quantity: total_item_inventory, food_trucks: trucks_with_item}
    end

    total_inventory
  end

  def overstocked_items()
    #An item is overstocked if it is BOTH sold by > 1 food trucks AND total quantity > 50
    total_inventory().find_all do |item_name, item_hash|
      item_hash[:food_trucks].length > 1 && item_hash[:quantity] > 50
    end.map do |item|
      item[0]   #find_all returns array of hashes with name in array as first element, hence the [0] and need to map
    end
  end

  def date()
    #Return the start date of the event. By default, this is today's date.
    #(I note the date formatting in the README is "dd/mm/yyyy" - I ain't mad at it, just atypical for the US)
    Date.today.strftime("%d/%m/%y")
    #It is not clear to me if this should be set in initialize(); that would make more sense from a 'potentially breaks other tests' standpoint, I guess...
  end
end