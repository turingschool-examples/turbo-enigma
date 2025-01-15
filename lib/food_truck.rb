class FoodTruck
  attr_reader :name, :inventory

  def initialize(company_name)
    @name = company_name

    @inventory = {}
  end

end