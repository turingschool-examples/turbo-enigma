class FoodTruck
  attr_reader :name, :inventory

  def initialize(company_name)
    @name = company_name

    @inventory = {}     #For now, keep everything here.  Later could have arrays of objects for overall inventory, etc. and this could organize it
  end

  def check_stock(item)
    return 0 if !@inventory[item]
    @inventory[item]
  end

  def stock(item, number_of_items)
    #If item already exists, add it to that.  Otherwise create new entry
    if @inventory[item]
      @inventory[item] += number_of_items
    else
      @inventory[item] = number_of_items
    end
  end

  def potential_revenue()
    #Based on current inventory (and assuming it were all to be sold)
    @inventory.to_a.sum do |item|
      item[0].price * item[1]
    end
  end

end