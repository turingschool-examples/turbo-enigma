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
        food_trucks.map { |food_truck| food_truck.name }
    end

    def food_trucks_that_sell(item)
        food_trucks.find_all { |food_truck| food_truck.inventory.key?(item)}
    end

    def sorted_item_list
        item_names = []
        @food_trucks.each do |food_truck|
            food_truck.inventory.each do |item, quantity|
                item_names << item.name
            end
        end
        item_names.uniq.sort 
    end

    def total_inventory
        total_inventory = {}

        @food_trucks.each do |food_truck|
            food_truck.inventory each do |item, quantity|
                
            end
        end
    end
end