# Food Truck Event

## Instructions

* Fork this Repository
* Clone your forked repo to your computer.
* Complete the activity below.
* Push your solution to your forked repo
* Submit a pull request from your repository to this repository
  * Put your name in your PR!

## Iteration 1 - Items & FoodTrucks

Graded Items:

1. Create an Item with attributes: `Item.new`
1. Create a FoodTruck with attributes: `FoodTruck.new`
1. Check quantity of an Item on the FoodTruck: `FoodTruck #check_stock`
1. Stock an Item on the FoodTruck: `FoodTruck #stock`

The Event will need to keep track of its FoodTrucks and their Items. Each FoodTruck will be able to report its total inventory, stock items, and return the quantity of items. Any item not in stock should return `0` by default.

Use TDD to create a `FoodTruck` class that responds to the following interaction pattern:

```ruby
pry(main)> require './lib/item'
#=> true

pry(main)> require './lib/food_truck'
#=> true

pry(main)> item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
#=> #<Item:0x007f9c56740d48...>

pry(main)> item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
#=> #<Item:0x007f9c565c0ce8...>

pry(main)> item2.name
#=> "Apple Pie (Slice)"

pry(main)> item2.price
#=> 2.50

pry(main)> food_truck = FoodTruck.new("Rocky Mountain Pies")
#=> #<FoodTruck:0x00007f85683152f0...>

pry(main)> food_truck.name
#=> "Rocky Mountain Pies"

pry(main)> food_truck.inventory
#=> {}

pry(main)> food_truck.check_stock(item1)
#=> 0

pry(main)> food_truck.stock(item1, 30)

pry(main)> food_truck.inventory
#=> {#<Item:0x007f9c56740d48...> => 30}

pry(main)> food_truck.check_stock(item1)
#=> 30

pry(main)> food_truck.stock(item1, 25)

pry(main)> food_truck.check_stock(item1)
#=> 55

pry(main)> food_truck.stock(item2, 12)

pry(main)> food_truck.inventory
#=> {#<Item:0x007f9c56740d48...> => 55, #<Item:0x007f9c565c0ce8...> => 12}
```

## Iteration 2 - Event and FoodTrucks

Graded Items:

1. Create an Event with attributes: `Event.new`
1. Add a FoodTruck to an Event: `Event #add_food_truck`
1. Return the list of FoodTruck names for an Event: `Event #food_truck_names`
1. Return the list of FoodTrucks that sell a given Item for an Event: `Event #food_trucks_that_sell`
1. Return the potential revenue from a FoodTruck: `FoodTruck #potential_revenue`

A `FoodTruck` will be able to calculate their `potential_revenue` - the sum of all their items' price * quantity.

A `Event` is responsible for keeping track of `FoodTruck`s. It should have a method called `food_truck_names` that returns an array of all the `FoodTruck` names.

Additionally, the `Event` should have a method called `food_trucks_that_sell` that takes an argument of an `Item` object and returns a list of `FoodTruck`s that have that item in stock.

Use TDD to create a `Event` class that responds to the following interaction pattern:

```ruby
pry(main)> require './lib/item'
#=> true

pry(main)> require './lib/food_truck'
#=> true

pry(main)> require './lib/event'
#=> true

pry(main)> event = Event.new("South Pearl Street Farmers Market")    
#=> #<Event:0x00007fe134933e20...>

pry(main)> event.name
#=> "South Pearl Street Farmers Market"

pry(main)> event.food_trucks
#=> []

pry(main)> food_truck1 = FoodTruck.new("Rocky Mountain Pies")
#=> #<FoodTruck:0x00007fe1348a1160...>

pry(main)> item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
#=> #<Item:0x007f9c56740d48...>

pry(main)> item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
#=> #<Item:0x007f9c565c0ce8...>

pry(main)> item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
#=> #<Item:0x007f9c562a5f18...>

pry(main)> item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
#=> #<Item:0x007f9c56343038...>

pry(main)> food_truck1.stock(item1, 35)    

pry(main)> food_truck1.stock(item2, 7)    

pry(main)> food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")    
#=> #<FoodTruck:0x00007fe1349bed40...>

pry(main)> food_truck2.stock(item4, 50)    

pry(main)> food_truck2.stock(item3, 25)

pry(main)> food_truck3 = FoodTruck.new("Palisade Peach Shack")    
#=> #<FoodTruck:0x00007fe134910650...>

pry(main)> food_truck3.stock(item1, 65)  

pry(main)> event.add_food_truck(food_truck1)    

pry(main)> event.add_food_truck(food_truck2)    

pry(main)> event.add_food_truck(food_truck3)

pry(main)> event.food_trucks
#=> [#<FoodTruck:0x00007fe1348a1160...>, #<FoodTruck:0x00007fe1349bed40...>, #<FoodTruck:0x00007fe134910650...>]

pry(main)> event.food_truck_names
#=> ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"]

pry(main)> event.food_trucks_that_sell(item1)
#=> [#<FoodTruck:0x00007fe1348a1160...>, #<FoodTruck:0x00007fe134910650...>]

pry(main)> event.food_trucks_that_sell(item4)
#=> [#<FoodTruck:0x00007fe1349bed40...>]

pry(main)> food_truck1.potential_revenue
#=> 148.75

pry(main)> food_truck2.potential_revenue
#=> 345.00

pry(main)> food_truck3.potential_revenue
#=> 243.75  
```

## Iteration 3 - Items sold at the Event

Use TDD to update the `Event` class so that it adds the following functionality. You need to complete at least 2 of the 3 methods in Iteration 3 to pass, as well as all of Iteration 1 and 2. 


1. An `Event` can return a list of *names* of all items the `FoodTrucks` have in stock, sorted alphabetically. This list should not include any duplicate items.
1. An `Event` can return a hash of total inventory that reports the available inventory of all items sold at the event. Specifically, it should include:
    - All items available for sale, and each item should identify the total inventory/quantity for that item, as well as a list of `FoodTruck`s that sell that item.
1. Return a list of overstocked Items for an `Event`. An item is overstocked if it is sold by more than 1 food truck AND the total quantity is greater than 50.

| Method Name               |      Return Value (type)
| ------------------------- | ---------------------------
| `sorted_item_list`        | Alphabetically sorted `Array` of all `FoodTruck` item <u>names</u> (no duplicates!). Array of Strings.
| `total_inventory`         | `Hash` with `Item`s as keys and a sub-hash as the value. The sub-hash should have `quantity` and `food_trucks` keys.(See example below)
| `overstocked_items`         | `Array` of `Item` objects

```ruby
# event.total_inventory

#=> {
#     <Item 1> => {
#       quantity: <n>,
#       food_trucks: [<FoodTruck 1>, <FoodTruck 2>]
#     },
#     <Item 2> => {
#       quantity: <n>,
#       food_trucks: [<FoodTruck 1>]
#     },
#     <Item 3> => {
#       quantity: <n>,
#       food_trucks: [<FoodTruck 3>]
#     },
#     ...
#   }
```

## Iteration 4 - Selling Items

Use TDD to update the `Event` class so that it adds the following functionality:

1. Event #date
2. Event #sell

| Method Name | Return Value |
| ----------- | ------------ |
| `date`       | string ex. `"24/02/2023"` (see below) |
| `sell(item, quantity)` | boolean (see below) |

**#date**

You will need to add `require "date"` to the top of your `Event` class.

An `Event` has a start date that is returned in the format of `"dd/mm/yyyy"`. The addition of a `date` to the `Event` should NOT break any previous tests. We want you to test this with a date that is IN THE PAST. In order to test the date method in a way that will work today, tomorrow and on any date in the future, you will need to use a [stub](https://backend.turing.edu/module1/lessons/mocks_stubs#:~:text=full%20Paint%20objects.-,Stubs,-In%20our%20next) 🙂.

**#sell**

An `Event` can sell an item of a given quantity. There are two possible outcomes for selling an item:

  - If the `Event` does not have enough of the item in stock to satisfy the given quantity, this method should return `false`.
  - If the `Event` has enough of the item in stock to satisfy the given quantity, this method should return `true`. Additionally, this method should reduce the stock of the `FoodTruck`. It should look through the `FoodTruck`s in the order they were added and sell the item from the first `FoodTruck` with that item in stock. If that `FoodTruck` does not have enough stock to satisfy the given quantity, the `FoodTruck`'s entire stock of that item will be depleted, and the remaining quantity will be sold from the next `FoodTruck` with that item in stock. It will follow this pattern until the entire quantity requested has been sold.

For example, suppose food_truck1 has 35 `peach pies` and food_truck3 has 65 `peach pies`, and food_truck1 was added to the event first. If the method `sell(<ItemXXX, @name = 'Peach Pie'...>, 40)` is called, the method should return `true`, food_truck1's new stock of `peach pies` should be 0, and food_truck3's new stock of `peach pies` should be 60.
