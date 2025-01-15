require 'pry'

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
        @food_trucks.map { |truck| truck.name }
    end

    def food_trucks_that_sell(item)
        @food_trucks.find_all { |truck| truck.inventory.key?(item) }
    end

    def sorted_item_list
        @food_trucks.flat_map do |truck|
            truck.inventory.keys.map { |item| item.name }
        end.uniq
    end

    def total_inventory
        #iterate over all food trucks at event
        #then go through that trucks inventory
        inventory = {} #empty hash
            @food_trucks.each do |truck| #go thru each foodtruck
                truck.inventory.each do |item, quantity| #go thru inventory
                    if inventory[item] #if item is in truck inventory
                        inventory[item][:quantity] += quantity #add quantity to exisiting total
                        inventory[item][:food_trucks] << truck unless inventory[item][:food_trucks].include?(truck)
                        #^adds food truck to the list if its not already there
                    else #if item is not in inventory hash, add item with quantity and food truck that sells it
                        inventory[item] = {
                        quantity: quantity,
                        food_trucks:[truck]
                        }
                    end
                end
            end
        inventory
    end
end