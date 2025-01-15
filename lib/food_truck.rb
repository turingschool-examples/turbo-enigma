class FoodTruck
    attr_reader :name, :inventory

    def initialize(name)
        @name = name
        @inventory = {}
    end

    def check_stock(item)
        if @inventory.include?(item)
            @inventory[item]
        else
            0
        end
    end

    def stock(item, amount)
        if @inventory.include?(item)
            @inventory[item] += amount
        else
            @inventory[item] = amount
        end
    end

    def potential_revenue
        total_revenue = 0
        
        @inventory.each do |item, amount|
            total_revenue += amount * item.price.delete("$").to_f
        end
        total_revenue
    end
end