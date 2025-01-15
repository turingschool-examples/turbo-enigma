require './lib/item'
require './lib/food_truck'
require './lib/event'

# Iteration 1
item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
food_truck = FoodTruck.new("Rocky Mountain Pies")

puts food_truck.name
#=> "Rocky Mountain Pies"

puts food_truck.inventory
#=> {}

puts food_truck.check_stock(item1)
#=> 0

food_truck.stock(item1, 30)
puts food_truck.inventory
#=> {#<Item:0x007f9c56740d48...> => 30}

puts food_truck.check_stock(item1)
#=> 30

food_truck.stock(item1, 25)
puts food_truck.check_stock(item1)
#=> 55

food_truck.stock(item2, 12)
puts food_truck.inventory
#=> {#<Item:0x007f9c56740d48...> => 55, #<Item:0x007f9c565c0ce8...> => 12}

# Iteration 2
event = Event.new("South Pearl Street Farmers Market")
puts event.name
#=> "South Pearl Street Farmers Market"

puts event.food_trucks
#=> []

food_truck1 = FoodTruck.new("Rocky Mountain Pies")
food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
food_truck3 = FoodTruck.new("Palisade Peach Shack")

item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

food_truck1.stock(item1, 35)
food_truck1.stock(item2, 7)
food_truck2.stock(item4, 50)
food_truck2.stock(item3, 25)
food_truck3.stock(item1, 65)

event.add_food_truck(food_truck1)
event.add_food_truck(food_truck2)
event.add_food_truck(food_truck3)

puts event.food_trucks
#=> [#<FoodTruck:0x00007fe1348a1160...>, #<FoodTruck:0x00007fe1349bed40...>, #<FoodTruck:0x00007fe134910650...>]

puts event.food_truck_names
#=> ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"]

puts event.food_trucks_that_sell(item1)
#=> [#<FoodTruck:0x00007fe1348a1160...>, #<FoodTruck:0x00007fe134910650...>]

puts event.food_trucks_that_sell(item4)
#=> [#<FoodTruck:0x00007fe1349bed40...>]

puts food_truck1.potential_revenue
#=> 148.75

puts food_truck2.potential_revenue
#=> 345.00

puts food_truck3.potential_revenue
#=> 243.75

# Iteration 3
puts event.sorted_item_list
#=> ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"]

puts event.total_inventory
#=> {
#     #<Item:0x007f9c56740d48...> => {
#       quantity: 100,
#       food_trucks: [#<FoodTruck:0x00007fe1348a1160...>, #<FoodTruck:0x00007fe134910650...>]
#     },
#     #<Item:0x007f9c565c0ce8...> => {
#       quantity: 50,
#       food_trucks: [#<FoodTruck:0x00007fe1349bed40...>]
#     }
#   }

puts event.overstocked_items
#=> [#<Item:0x007f9c56740d48...>]
