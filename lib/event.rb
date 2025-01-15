# frozen_string_literal: true

# Create an event to host food trucks
class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck| # rubocop:disable Style/SymbolProc
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |food_truck|
      food_truck.inventory[item]
    end
  end

  def sorted_item_list
    @food_trucks.map do |food_truck|
      food_truck.inventory.keys.map do |item| # rubocop:disable Style/SymbolProc
        item.name
      end
    end.flatten.uniq.sort
  end
end
