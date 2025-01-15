class Item
    attr_reader :name

    def initialize(item_params)
        @name = item_params[:name]
        @price = item_params[:price]
    end

    def price 
        @price[1..-1].to_f
    end
end