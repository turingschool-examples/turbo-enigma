# frozen_string_literal: true

# Create an item to stock on the food truck
class Item
  attr_reader :name

  def initialize(item_params)
    @name = item_params[:name]
  end
end
