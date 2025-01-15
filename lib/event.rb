# frozen_string_literal: true

# Create an event to host food trucks
class Event
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
