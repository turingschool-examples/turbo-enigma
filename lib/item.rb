class Item
  attr_reader :name, :price

  def initialize(input_hash)
    @name = input_hash[:name]
    @price = input_hash[:price].delete_prefix("$").to_f.round(2)
    # @price.slice!(0, 1).to_i

  end

end
