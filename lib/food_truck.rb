class FoodTruck
    attr_reader :name, :inventory

    def initialize(name)
        @name = name
        @inventory = {}
    end

    def check_stock(item)
        @inventory[item].to_i
    end

    def stock(item, ammount)
        if @inventory[item]
            @inventory[item] += ammount
        else
            @inventory[item] = ammount
        end
    end

    def potential_revenue
        revenue = 0.0
        @inventory.each { |item, ammount| revenue += item.price * ammount }
        revenue
    end
end