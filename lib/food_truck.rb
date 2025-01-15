require 'pry'

class FoodTruck
    attr_reader :name, :inventory

    def initialize(name)
        @name = name
        @inventory = Hash.new(0)
    end

    def check_stock(item)
        @inventory[item]
    end
    
    def stock(item, quantity)
        @inventory[item] += quantity
    end

    def potential_revenue
        @inventory.sum { |item, quantity| quantity * item.price.delete("$").to_f }
    end
    
end