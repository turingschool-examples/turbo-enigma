# frozen_string_literal: true

# Create an item to stock on the food truck
class Item
  attr_reader :name, :price

  def initialize(item_params)
    @name = item_params[:name]
    @price = item_params[:price].delete_prefix('$').to_f
  end
end
