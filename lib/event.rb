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
        @food_trucks.select do |truck| 
            truck.check_stock(item) > 0 
        end
    end

    def sorted_item_list 
        @food_trucks.flat_map do |truck|
            truck.inventory.keys.map do |item|
                item.name
            end
        end.uniq.sort
    end
end