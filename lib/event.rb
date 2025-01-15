# frozen_string_literal: true

# Create an event to host food trucks
class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end
end
