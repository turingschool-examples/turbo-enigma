class FoodTruck
    attr_reader :name, :inventory 
    
    def initialize(name)
        @name = name
        @inventory = {}
    end
    def check_stock(item)
        @inventory.fetch(item, 0)  
    end

    def stock(item, quantity)
        inventory[item] = check_stock(item) + quantity
    end

    def potential_revenue
        @inventory.sum do |item, quantity|
            item.price * quantity
            
        end
    end
end