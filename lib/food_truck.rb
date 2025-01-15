class FoodTruck
  attr_reader :name, :inventory

  def initialize(company_name)
    @name = company_name

    @inventory = {}
  end

  def check_stock(item)
    return 0 if !@inventory[item]
    @inventory[item]
  end

  def stock(item, number_of_items)
    if @inventory[item]
      @inventory[item] += number_of_items
    else
      @inventory[item] = number_of_items
    end
  end

  def potential_revenue()
    #Based on current inventory (and assuming it were all to be sold)
    # @inventory.to_a.sum do |item|
    #   item[0].price * item[1]
    # end

    #Alternate approach running the enumerable directly on the hash (I guess a little more readable):
    @inventory.sum do |item, quantity|
      item.price * quantity
    end
  end

end