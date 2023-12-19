class Inventory

  #Setter for quantity object
  # attr_writer :quantity

  def initialize
    @hash = {}
    @info =[]
  end

  def add_info(name, price, quantity)
    return puts 'sorry the iteam you want to add is already in inventory' if @hash.key?(name);
    @hash[name] = {'name'=> name, 'price'=>price, 'quantity'=> quantity}
    @info.push(@hash[name])
  end

  def update_info(name, new_info)
    puts name
    if @hash.key?(name)
      return @hash[name]['price'] = new_info if new_info.instance_of? Integer
      @hash[name]['name'] = new_info
      @hash[new_info] = @hash.delete(name)  #For repalcing old hash keys into new updated name hash keys
    else
      puts "Error: Please enter valid informations"
    end
  end

  def update_quantity(name, new_quantity, type)
    case type
    when 'Increase'
      @hash[name]['quantity'] += new_quantity

    when 'Decrease'
      return 'Quantity of items is less than quantity you want to decrease' if @hash[name]['quantity'] < new_quantity
      @hash[name]['quantity']  -= new_quantity if @hash[name]['quantity'] > 0
    end
  end


  def info
    return @info, @hash
  end

end


class Cli

  def initialize(inventory)
    @inventory = inventory

  end

  def start
    puts 'Please enter 1 for adding item, 2 for viewing inventory, 3 for updating name, 4 for updating price, 5 for updating '
    res = gets.chomp.to_i

    add if res == 1
    show_inventory if res == 2
    update_name if res == 3
    update_price if res == 4
    update_quantity if res == 5
  end

  def add
    puts 'Please mention the item name you want to add'
    name = gets.chomp

    puts 'Please mention price of that item too'
    price = gets.chomp.to_i

    puts 'How many quantity you want'
    quantity = gets.chomp.to_i

     if quantity == 0 or price == 0
      puts 'Please enter valid number for quantity and price'
      start
     end

    @inventory.add_info(name, price, quantity)

    start

  end

  def show_inventory
    puts @inventory.info

    start
  end

  def update_helper(prompt, update_method)
    puts 'Insert the name of the item you want to update'
    old_value = gets.chomp
    puts "Insert the new #{prompt} you want to assign"
     if prompt == 'name'
      new_value = gets.chomp
     else
      new_value = gets.chomp.to_i
      return puts 'Enter valid figure' if new_value == 0
     end
    @inventory.send(update_method, old_value, new_value) #send method can invoke methods of other class while passing arguments through send
  end

  def update_name
    update_helper('name', :update_info)
    start
  end

  def update_price
    update_helper('price', :update_info)
    start
  end


  def update_quantity
    puts 'Please Enter 1 to increase quantity and 2 for decrease quantity'
    res = gets.chomp.to_i
    case res
    when 0
      puts "Please enter a valid numbers as told"
      start
    when 1
      manipulate_quantity('Increase')
      start
    when 2
      manipulate_quantity('Decrease')
      start
    end
    # return increase_quantity if gets.chomp.to_i =
    # puts 'how much quantity do you want to increase'
    # quantity = gets.chomp.to_i
  end


  def manipulate_quantity(type)
    puts 'insert the name of item you want to update its quantity'
    name = gets.chomp
    puts "You want to #{type} quantity, how much you want to #{type} quantity"
    new_quantity = gets.chomp.to_i
    return puts 'Enter valid figure' if new_quantity == 0
    @inventory.update_quantity(name, new_quantity, type)
  end
end







inventory = Inventory.new

cli = Cli.new(inventory)

cli.start
# inventory.quantity = LowerQunatity.new
# inventory.show_quantity


# inventory.add_info( "unesh", 22, "sad")
# inventory.add_info("raju", 18, "exited")
# inventory.add_info("rohan", 30, "happy")


# puts inventory.info;
