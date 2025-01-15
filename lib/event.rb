# frozen_string_literal: true

require 'date'

# Create an event to host food trucks
class Event
  attr_reader :name, :food_trucks, :date

  def initialize(name, date = Date.today.strftime('%d/%m/%Y'))
    @name = name
    @food_trucks = []
    @date = date
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

  def total_inventory # rubocop:disable Metrics/MethodLength
    total_inventory = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, amount|
        if total_inventory[item].nil?
          total_inventory[item] = { quantity: amount, food_trucks: [food_truck] }
        else
          total_inventory[item][:quantity] += amount
          total_inventory[item][:food_trucks] << food_truck
        end
      end
    end
    total_inventory
  end

  def overstocked_items
    total_inventory.select do |_item, item_hash|
      item_hash[:quantity] > 50 && item_hash[:food_trucks].length > 1
    end.keys
  end

  def sell(item, amount)
    return false if total_inventory[item][:quantity] < amount

    
    true
  end
end
