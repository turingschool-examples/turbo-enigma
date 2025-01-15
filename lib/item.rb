#create item with attributes (name, price)

class Item
  attr_reader :name, :price

  def initialize(details) 
    @name = details[:name]
    @price = details[:price].delete('$').to_f
    #.delete('$') removes the dollar sign from the price
    #to_f converts the string to a float
  end
end
