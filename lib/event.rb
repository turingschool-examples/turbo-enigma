require 'date'

class Event
    attr_reader :name, :food_trucks

    def initialize(name)
        @name = name
        @food_trucks = []
        @date = Date.today
    end

    def date 
        @date.strftime("%d/%m/%Y")
    end

    def add_food_truck(truck)
        @food_trucks << truck
    end

    def food_truck_names
        @food_trucks.map{ |truck| truck.name }
    end

    def trucks_that_sell(item)
        @food_trucks.find_all { |truck| truck.check_stock(item) > 0 }
    end

    def sorted_item_list
        all_items.map { |item| item.name }.sort
    end

    def total_inventory
        total_inventory = {}

        all_items.each do |item|
            item_hash = {}

            item_hash[:quantity] = total_quantity(item)
            item_hash[:food_trucks] = trucks_that_sell(item)

            total_inventory[item] = item_hash
        end

        total_inventory
    end

    def overstocked_items
        items = []

        all_items.each do |item|
            if total_quantity(item) > 50 && trucks_that_sell(item).size > 1
                items << item
            end
        end

        items
    end

    private

    def all_items
        items = []
        @food_trucks.each do |truck|
            truck.inventory.each do |item, quantity| 
                items << item if !items.include?(item)
            end
        end
        items
    end

    def total_quantity(item)
        trucks_that_sell(item).sum { |truck| truck.check_stock(item) }
    end
end