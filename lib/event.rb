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
        food_truck_list = []
        
        @food_trucks.each do |food_truck|
            food_truck_list << food_truck.name
        end
        food_truck_list
    end

    def food_trucks_that_sell(item)
        @food_trucks.select do |food_truck|
            food_truck.inventory.include?(item)
        end
    end

    def sorted_item_list
        all_items = []

        @food_trucks.each do |foodtruck|
            foodtruck.inventory.keys.each do |item|
                all_items << item
            end
        end

        item_names = []

        all_items.each do |item|
            item_names << item.name 
        end
        
        unique_items = item_names.uniq
        sorted_items = unique_items.sort

        sorted_items
    end

    def overstocked_items
        overstocked_items = []

        unique_items = @food_trucks.flat_map do |food_truck|
            food_truck.inventory.keys
        end.uniq

        unique_items.each do |item|
            total_inventory = 0
            food_truck_count = 0

            @food_trucks.each do |food_truck|
                if food_truck.inventory[item]
                    total_inventory += food_truck.inventory[item] 
                    food_truck_count += 1 
                end
            end

            if total_inventory > 50 || food_truck_count > 1
                overstocked_items << item
            end
        end
        overstocked_items
    end
end
